/*
 Navicat Premium Data Transfer

 Source Server         : 开发
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : 192.168.0.238:3306
 Source Schema         : laravel-package

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 09/04/2019 11:11:01
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of process_instance
-- ----------------------------
BEGIN;
INSERT INTO `process_instance` VALUES (1, 1, '林润审批', 1, 0, 0, NULL, '0000-00-00 00:00:00', '2019-04-03 09:20:02', '2019-04-03 09:20:02');
INSERT INTO `process_instance` VALUES (2, 1, '林润审批', 1, 0, 0, NULL, '0000-00-00 00:00:00', '2019-04-03 10:48:09', '2019-04-03 10:48:09');
INSERT INTO `process_instance` VALUES (3, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:56', '2019-04-03 10:48:56');
INSERT INTO `process_instance` VALUES (4, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:56', '2019-04-03 10:48:56');
INSERT INTO `process_instance` VALUES (5, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:57', '2019-04-03 10:48:57');
INSERT INTO `process_instance` VALUES (6, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:57', '2019-04-03 10:48:57');
INSERT INTO `process_instance` VALUES (7, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:57', '2019-04-03 10:48:57');
INSERT INTO `process_instance` VALUES (8, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:57', '2019-04-03 10:48:57');
INSERT INTO `process_instance` VALUES (9, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:57', '2019-04-03 10:48:57');
INSERT INTO `process_instance` VALUES (10, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:57', '2019-04-03 10:48:57');
INSERT INTO `process_instance` VALUES (11, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:58', '2019-04-03 10:48:58');
INSERT INTO `process_instance` VALUES (12, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:59', '2019-04-03 10:48:59');
INSERT INTO `process_instance` VALUES (13, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:59', '2019-04-03 10:48:59');
INSERT INTO `process_instance` VALUES (14, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:59', '2019-04-03 10:48:59');
INSERT INTO `process_instance` VALUES (15, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:48:59', '2019-04-03 10:48:59');
INSERT INTO `process_instance` VALUES (16, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:49:00', '2019-04-03 10:49:00');
INSERT INTO `process_instance` VALUES (17, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:49:00', '2019-04-03 10:49:00');
INSERT INTO `process_instance` VALUES (18, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:49:00', '2019-04-03 10:49:00');
INSERT INTO `process_instance` VALUES (19, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 10:49:00', '2019-04-03 10:49:00');
INSERT INTO `process_instance` VALUES (20, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 16:44:01', '2019-04-03 16:44:01');
INSERT INTO `process_instance` VALUES (21, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-03 16:44:31', '2019-04-03 16:44:31');
INSERT INTO `process_instance` VALUES (22, 1, '林润审批', 1, 0, 0, NULL, NULL, '2019-04-08 13:23:51', '2019-04-08 13:23:51');
COMMIT;

-- ----------------------------
-- Table structure for process_node
-- ----------------------------
DROP TABLE IF EXISTS `process_node`;
CREATE TABLE `process_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `process_id` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `title` varchar(255) NOT NULL COMMENT '任务名称',
  `node_type` varchar(255) NOT NULL COMMENT 'event,task,gateway中的一个',
  `node_id` int(11) NOT NULL COMMENT '对应各表中的ID',
  `condition` varchar(255) DEFAULT '' COMMENT '上个节点为网关时，用于记录网关流向的条件',
  `sort` int(11) NOT NULL DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8 COMMENT='流程节点表';

-- ----------------------------
-- Records of process_node
-- ----------------------------
BEGIN;
INSERT INTO `process_node` VALUES (1, 1, '流程开始', 'event', 0, '', 1, NULL);
INSERT INTO `process_node` VALUES (2, 1, '征信申请', 'task', 0, '', 2, NULL);
INSERT INTO `process_node` VALUES (3, 1, '银行征信查询', 'task', 0, '($loan_bank == 01) || ($loan_bank == 02) || ($loan_bank == 03)|| ($loan_bank == 06)', 3, NULL);
INSERT INTO `process_node` VALUES (5, 1, '征信拒件', 'event', 0, '$inquire_status == 2', 5, NULL);
INSERT INTO `process_node` VALUES (6, 1, '流程中止', 'end', 0, '', 6, NULL);
INSERT INTO `process_node` VALUES (7, 1, '家访签约', 'task', 0, '$need_home_visit == 1', 7, NULL);
INSERT INTO `process_node` VALUES (8, 1, '申请录入', 'task', 0, '$need_home_visit == 2 || ($need_home_visit == 1 && $visit_status == 1)', 11, NULL);
INSERT INTO `process_node` VALUES (9, 1, '人工一审', 'task', 0, '($artificialoneinit_status == 1 && !$artificialone_status) || ($supplement_sale_init_status == 0 && $supplement_sale_one_status == 1 && $supplement_sale_two_status == 0)', 11, NULL);
INSERT INTO `process_node` VALUES (10, 1, '一审是否通过', 'gateway', 0, '', 12, NULL);
INSERT INTO `process_node` VALUES (11, 1, '家访拒件', 'event', 0, '$visit_status == 2', 9, NULL);
INSERT INTO `process_node` VALUES (12, 1, '流程中止', 'end', 0, '', 10, NULL);
INSERT INTO `process_node` VALUES (13, 1, '补充资料（家访）', 'task', 0, '($artificialone_status == 3 || $artificialtwo_status == 3) && $supplement_visit==1', 15, '所有补充完资料任务后继续进入一审任务');
INSERT INTO `process_node` VALUES (14, 1, '二审拒件', 'event', 0, '$artificialtwo_status == 2', 19, '');
INSERT INTO `process_node` VALUES (15, 1, '二审是否通过', 'gateway', 0, '', 18, NULL);
INSERT INTO `process_node` VALUES (16, 1, '流程中止', 'end', 0, '', 20, NULL);
INSERT INTO `process_node` VALUES (32, 1, '流程结束', 'event', 0, '', 27, NULL);
INSERT INTO `process_node` VALUES (34, 1, '家访是否通过', 'gateway', 0, '', 8, NULL);
INSERT INTO `process_node` VALUES (35, 1, '一审拒件', 'event', 0, '$artificialone_status == 2', 13, NULL);
INSERT INTO `process_node` VALUES (36, 1, '流程中止', 'end', 0, '', 14, NULL);
INSERT INTO `process_node` VALUES (37, 1, '人工二审', 'task', 0, '($artificialone_status == 1 && $loan_prize >=0) || ($supplement_sale_init_status == 0 && $supplement_sale_one_status == 0 && $supplement_sale_two_status == 1)', 17, NULL);
INSERT INTO `process_node` VALUES (39, 1, '财务打款', 'task', 0, '$moneyaudit_status == 1', 21, NULL);
INSERT INTO `process_node` VALUES (40, 1, '回款确认', 'task', 0, '', 22, NULL);
INSERT INTO `process_node` VALUES (41, 1, '寄件登记', 'task', 0, '$artificialtwo_status == 1 || ($artificialone_status == 1 && $loan_prize <0)', 23, NULL);
INSERT INTO `process_node` VALUES (42, 1, '抄单登记', 'task', 0, '', 24, NULL);
INSERT INTO `process_node` VALUES (43, 1, 'GPS登记', 'task', 0, '', 25, NULL);
INSERT INTO `process_node` VALUES (44, 1, '抵押登记', 'task', 0, '', 26, NULL);
INSERT INTO `process_node` VALUES (45, 1, '申请件补件', 'task', 0, '($artificialoneinit_status == 3 || $artificialone_status == 3 || $artificialtwo_status == 3) && $supplement_salesman==1', 16, '所有补充完资料任务后继续进入一审任务');
INSERT INTO `process_node` VALUES (46, 1, '是否补件完成', 'gateway', 0, '(!$supplement_visit || $supplement_visit == 3) && (!$supplement_salesman || $supplement_salesman == 3)', 16, NULL);
INSERT INTO `process_node` VALUES (47, 1, '申请打款', 'task', 0, '$artificialtwo_status == 1 || ($artificialone_status == 1 && $loan_prize <0)', 0, NULL);
INSERT INTO `process_node` VALUES (48, 1, '打款审核', 'task', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (49, 1, '打款审核是否通过', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (50, 1, '打款审核拒件', 'event', 0, '$moneyaudit_status == 2', 0, NULL);
INSERT INTO `process_node` VALUES (51, 1, '流程终止', 'end', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (52, 2, '流程开始', 'event', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (53, 2, '融资申请', 'task', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (54, 2, '融资申请后台审核', 'task', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (55, 2, '融资申请审核是否通过', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (56, 2, '融资申请拒绝', 'event', 0, '$crsrequest_status == 2', 0, NULL);
INSERT INTO `process_node` VALUES (57, 2, '流程中止', 'end', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (58, 2, '上标申请', 'task', 0, '$crsrequest_status == 1', 0, NULL);
INSERT INTO `process_node` VALUES (59, 2, '流程终止', 'end', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (60, 1, '银行征信查询', 'task', 0, '$loan_bank == 04 || $loan_bank == 05', 0, NULL);
INSERT INTO `process_node` VALUES (61, 1, '征信申请流程选择', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (62, 1, '分公司初审', 'task', 0, '($inputrequest_status == 1 && !$artificialoneinit_status && !$artificialone_status) || ($supplement_sale_init_status == 1 && $supplement_sale_one_status == 0 && $supplement_sale_two_status == 0)', 0, NULL);
INSERT INTO `process_node` VALUES (63, 1, '分公司初审是否通过', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (64, 1, '分公司初审拒件', 'event', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (65, 1, '订单归档', 'task', 0, '$task_gps_complete == 1 && $task_repay_complete == 1', 0, NULL);
INSERT INTO `process_node` VALUES (66, 1, '订单归档网关', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (67, 1, '选择审核银行', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (68, 1, '临沂经开行审核', 'task', 0, '$review_bank_id == \"03\" && $review_bank_supplement != \"us\"', 0, NULL);
INSERT INTO `process_node` VALUES (69, 1, '判断临沂经开行审核结果', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (70, 1, '银行审核通过', 'event', 0, '$review_bank_status == \"success\"', 0, NULL);
INSERT INTO `process_node` VALUES (71, 1, '临沂经开行补件', 'task', 0, '$review_bank_supplement == \"bank\"', 0, NULL);
INSERT INTO `process_node` VALUES (72, 1, '临沂经开行补件结果', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (73, 1, '我方补临沂经开行件', 'task', 0, '$review_bank_supplement == \"us\"', 0, NULL);
INSERT INTO `process_node` VALUES (74, 1, '银行审核拒件', 'event', 0, '$review_bank_status == \"refuse\"', 0, NULL);
INSERT INTO `process_node` VALUES (75, 1, '推送银行数据', 'task', 0, '$ready_to_bank == 1', 0, NULL);
INSERT INTO `process_node` VALUES (76, 1, '二审通过后补件', 'task', 0, '$ready_to_bank == 2', 0, NULL);
INSERT INTO `process_node` VALUES (77, 1, '征信网关', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (78, 1, '抵押审核', 'task', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (79, 1, '抵押审核处理', 'gateway', 0, '', 0, NULL);
INSERT INTO `process_node` VALUES (80, 1, '抵押审核通过', 'event', 0, '$pledgechec == \"success\"', 0, NULL);
INSERT INTO `process_node` VALUES (81, 1, '抵押审核待补件', 'task', 0, '$pledgechec == \"replacements\"', 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for process_node_instance
-- ----------------------------
DROP TABLE IF EXISTS `process_node_instance`;
CREATE TABLE `process_node_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `process_id` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `process_instance_id` int(11) NOT NULL DEFAULT '0' COMMENT '开始人ID',
  `node_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '任务名称',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1启动 2完成 3停止',
  `is_completed` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1已完成，0未完成',
  `is_stoped` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1已停止，0未停止',
  `is_locked` int(11) NOT NULL DEFAULT '0' COMMENT '>0表示被这个id的用户占用，=0表示可用',
  `complete_at` timestamp NULL DEFAULT NULL COMMENT '完成时间',
  `stop_at` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_process_instance_id` (`process_instance_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='节点状态表';

-- ----------------------------
-- Records of process_node_instance
-- ----------------------------
BEGIN;
INSERT INTO `process_node_instance` VALUES (25, 1, 21, 2, '征信申请', 2, 1, 0, 0, '2019-04-03 08:47:11', NULL, '2019-04-03 16:45:25', '2019-04-03 08:47:11');
INSERT INTO `process_node_instance` VALUES (26, 1, 21, 7, '家访签约', 2, 1, 0, 0, '2019-04-03 08:48:08', NULL, '2019-04-03 16:47:11', '2019-04-03 08:48:08');
INSERT INTO `process_node_instance` VALUES (27, 1, 21, 8, '申请录入', 1, 0, 0, 0, NULL, NULL, '2019-04-03 16:48:08', '2019-04-03 16:48:08');
INSERT INTO `process_node_instance` VALUES (28, 1, 22, 2, '征信申请', 2, 1, 0, 0, '2019-04-08 07:11:06', NULL, '2019-04-08 15:08:08', '2019-04-08 07:11:06');
INSERT INTO `process_node_instance` VALUES (29, 1, 22, 7, '家访签约', 1, 0, 0, 0, NULL, NULL, '2019-04-08 15:11:06', '2019-04-08 15:11:06');
COMMIT;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of process_node_link
-- ----------------------------
BEGIN;
INSERT INTO `process_node_link` VALUES (1, 1, 1, 0, 2);
INSERT INTO `process_node_link` VALUES (2, 1, 61, 2, 3);
INSERT INTO `process_node_link` VALUES (6, 1, 2, 1, 77);
INSERT INTO `process_node_link` VALUES (7, 1, 7, 4, 34);
INSERT INTO `process_node_link` VALUES (8, 1, 34, 7, 11);
INSERT INTO `process_node_link` VALUES (9, 1, 11, 34, 12);
INSERT INTO `process_node_link` VALUES (10, 1, 8, 34, 62);
INSERT INTO `process_node_link` VALUES (11, 1, 9, 63, 10);
INSERT INTO `process_node_link` VALUES (12, 1, 10, 9, 35);
INSERT INTO `process_node_link` VALUES (13, 1, 35, 10, 36);
INSERT INTO `process_node_link` VALUES (14, 1, 13, 10, 46);
INSERT INTO `process_node_link` VALUES (15, 1, 37, 10, 15);
INSERT INTO `process_node_link` VALUES (16, 1, 15, 37, 14);
INSERT INTO `process_node_link` VALUES (17, 1, 14, 15, 16);
INSERT INTO `process_node_link` VALUES (18, 1, 13, 15, 46);
INSERT INTO `process_node_link` VALUES (19, 1, 39, 15, 43);
INSERT INTO `process_node_link` VALUES (24, 1, 34, 7, 8);
INSERT INTO `process_node_link` VALUES (25, 1, 10, 9, 37);
INSERT INTO `process_node_link` VALUES (26, 1, 10, 9, 13);
INSERT INTO `process_node_link` VALUES (27, 1, 10, 9, 47);
INSERT INTO `process_node_link` VALUES (29, 1, 15, 37, 13);
INSERT INTO `process_node_link` VALUES (30, 1, 15, 37, 47);
INSERT INTO `process_node_link` VALUES (31, 1, 45, 10, 46);
INSERT INTO `process_node_link` VALUES (32, 1, 45, 15, 46);
INSERT INTO `process_node_link` VALUES (33, 1, 10, 9, 45);
INSERT INTO `process_node_link` VALUES (34, 1, 15, 37, 45);
INSERT INTO `process_node_link` VALUES (35, 1, 41, 15, 42);
INSERT INTO `process_node_link` VALUES (36, 1, 42, 41, 44);
INSERT INTO `process_node_link` VALUES (37, 1, 44, 42, 40);
INSERT INTO `process_node_link` VALUES (38, 1, 15, 37, 41);
INSERT INTO `process_node_link` VALUES (41, 1, 46, 13, 9);
INSERT INTO `process_node_link` VALUES (43, 1, 10, 9, 41);
INSERT INTO `process_node_link` VALUES (44, 1, 47, 15, 48);
INSERT INTO `process_node_link` VALUES (45, 1, 48, 47, 49);
INSERT INTO `process_node_link` VALUES (46, 1, 49, 48, 50);
INSERT INTO `process_node_link` VALUES (47, 1, 50, 49, 36);
INSERT INTO `process_node_link` VALUES (48, 1, 49, 48, 39);
INSERT INTO `process_node_link` VALUES (51, 1, 46, 45, 9);
INSERT INTO `process_node_link` VALUES (52, 1, 46, 45, 37);
INSERT INTO `process_node_link` VALUES (53, 2, 52, 0, 53);
INSERT INTO `process_node_link` VALUES (54, 2, 53, 52, 54);
INSERT INTO `process_node_link` VALUES (55, 2, 54, 53, 55);
INSERT INTO `process_node_link` VALUES (56, 2, 55, 54, 56);
INSERT INTO `process_node_link` VALUES (57, 2, 56, 55, 57);
INSERT INTO `process_node_link` VALUES (58, 2, 55, 54, 58);
INSERT INTO `process_node_link` VALUES (59, 1, 2, 1, 61);
INSERT INTO `process_node_link` VALUES (60, 1, 61, 2, 60);
INSERT INTO `process_node_link` VALUES (61, 1, 62, 8, 63);
INSERT INTO `process_node_link` VALUES (62, 1, 63, 8, 45);
INSERT INTO `process_node_link` VALUES (63, 1, 63, 62, 64);
INSERT INTO `process_node_link` VALUES (64, 1, 63, 62, 9);
INSERT INTO `process_node_link` VALUES (65, 1, 46, 45, 62);
INSERT INTO `process_node_link` VALUES (66, 1, 43, 39, 66);
INSERT INTO `process_node_link` VALUES (67, 1, 40, 44, 66);
INSERT INTO `process_node_link` VALUES (68, 1, 66, -1, 65);
INSERT INTO `process_node_link` VALUES (69, 1, 42, 41, 67);
INSERT INTO `process_node_link` VALUES (70, 1, 67, 42, 68);
INSERT INTO `process_node_link` VALUES (71, 1, 68, 67, 69);
INSERT INTO `process_node_link` VALUES (72, 1, 69, 68, 70);
INSERT INTO `process_node_link` VALUES (73, 1, 69, 68, 71);
INSERT INTO `process_node_link` VALUES (74, 1, 71, 69, 72);
INSERT INTO `process_node_link` VALUES (75, 1, 72, 71, 73);
INSERT INTO `process_node_link` VALUES (76, 1, 72, 71, 68);
INSERT INTO `process_node_link` VALUES (77, 1, 73, 72, 71);
INSERT INTO `process_node_link` VALUES (78, 1, 69, 68, 74);
INSERT INTO `process_node_link` VALUES (79, 1, 15, 37, 76);
INSERT INTO `process_node_link` VALUES (80, 1, 76, 15, 37);
INSERT INTO `process_node_link` VALUES (81, 1, 15, 37, 75);
INSERT INTO `process_node_link` VALUES (83, 1, 77, 2, 7);
INSERT INTO `process_node_link` VALUES (84, 1, 77, 2, 8);
INSERT INTO `process_node_link` VALUES (85, 1, 44, 42, 78);
INSERT INTO `process_node_link` VALUES (86, 1, 78, 44, 79);
INSERT INTO `process_node_link` VALUES (87, 1, 79, 78, 80);
INSERT INTO `process_node_link` VALUES (88, 1, 79, 78, 81);
INSERT INTO `process_node_link` VALUES (89, 1, 81, 79, 78);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
