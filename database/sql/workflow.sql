/*
 Navicat MySQL Data Transfer

 Source Server         : 开发-new
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 172.16.17.88:3306
 Source Schema         : yicheyun

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 12/07/2021 18:19:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for process
-- ----------------------------
DROP TABLE IF EXISTS `process`;
CREATE TABLE `process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '流程名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of process
-- ----------------------------
BEGIN;
INSERT INTO `process` VALUES (1, '林润审批');
COMMIT;

-- ----------------------------
-- Table structure for process_instance
-- ----------------------------
DROP TABLE IF EXISTS `process_instance`;
CREATE TABLE `process_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `process_id` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '流程名称',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1启动 2完成 3停止',
  `is_completed` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1已完成，0未完成',
  `is_stoped` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1已停止，0未停止',
  `complete_at` timestamp NULL DEFAULT NULL COMMENT '完成时间',
  `stop_at` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `process_id` (`process_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for process_node
-- ----------------------------
DROP TABLE IF EXISTS `process_node`;
CREATE TABLE `process_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `process_id` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `title` varchar(255) NOT NULL COMMENT '任务名称',
  `node_type` varchar(255) NOT NULL COMMENT 'event,task,gateway中的一个',
  `node_id` char(10) NOT NULL COMMENT '节点唯一标识',
  `sort` int(11) NOT NULL DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `process_id` (`process_id`,`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='流程节点表';

-- ----------------------------
-- Records of process_node
-- ----------------------------
BEGIN;
INSERT INTO `process_node` VALUES (1, 1, '流程开始', 'event', 'lcks', 1, NULL);
INSERT INTO `process_node` VALUES (2, 1, '征信申请', 'task', 'zxsq', 2, NULL);
INSERT INTO `process_node` VALUES (3, 1, '银行征信查询', 'task', 'yhzxcx', 3, NULL);
INSERT INTO `process_node` VALUES (5, 1, '征信拒件', 'event', 'zxjj', 5, NULL);
INSERT INTO `process_node` VALUES (6, 1, '流程中止', 'end', 'lczz', 6, NULL);
INSERT INTO `process_node` VALUES (9, 1, '人工一审', 'task', 'rgys', 11, NULL);
INSERT INTO `process_node` VALUES (10, 1, '一审网关', 'gateway', 'yswg', 12, NULL);
INSERT INTO `process_node` VALUES (14, 1, '人工二审', 'task', '0', 19, '');
INSERT INTO `process_node` VALUES (15, 1, '一审拒绝', 'task', '0', 18, NULL);
INSERT INTO `process_node` VALUES (16, 1, '人工三审', 'task', 'rgss', 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for process_node_instance
-- ----------------------------
DROP TABLE IF EXISTS `process_node_instance`;
CREATE TABLE `process_node_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `process_id` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `process_instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '开始人ID',
  `node_id` int(11) NOT NULL DEFAULT '0' COMMENT '当前节点',
  `pre_node_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上个节点id',
  `title` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '任务名称',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1启动 2完成 3停止,4:手动返回上一步',
  `is_completed` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1已完成，0未完成',
  `is_stoped` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1已停止，0未停止',
  `is_locked` int(11) NOT NULL DEFAULT '0' COMMENT '>0表示被这个id的用户占用，=0表示可用',
  `complete_at` timestamp NULL DEFAULT NULL COMMENT '完成时间',
  `stop_at` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_process_instance_id` (`process_instance_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='节点状态表';

-- ----------------------------
-- Table structure for process_node_link
-- ----------------------------
DROP TABLE IF EXISTS `process_node_link`;
CREATE TABLE `process_node_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `process_id` int(11) NOT NULL DEFAULT '0',
  `current_id` int(11) NOT NULL DEFAULT '0' COMMENT '当前任务进度ID',
  `prev_id` int(11) NOT NULL DEFAULT '0' COMMENT '前置任务的ID',
  `next_id` int(11) NOT NULL DEFAULT '0' COMMENT '下一个任务进度ID',
  `condition` varchar(255) NOT NULL DEFAULT '' COMMENT '当前任务条件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of process_node_link
-- ----------------------------
BEGIN;
INSERT INTO `process_node_link` VALUES (1, 1, 1, 0, 2, '');
INSERT INTO `process_node_link` VALUES (2, 1, 2, 1, 3, '');
INSERT INTO `process_node_link` VALUES (3, 1, 3, 2, 9, '');
INSERT INTO `process_node_link` VALUES (4, 1, 9, 3, 10, '');
INSERT INTO `process_node_link` VALUES (5, 1, 10, 9, 14, '$pass==1');
INSERT INTO `process_node_link` VALUES (6, 1, 10, 9, 15, '$pass==3');
INSERT INTO `process_node_link` VALUES (7, 1, 14, 14, 16, '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
