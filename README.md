# 流程引擎使用V1
## 安装
 - php artisan vendor:publish --tag=workflow --force
## 使用
### 建立独立流程
- 初始化流程线`process`
- 建立节点，网关等`process_node`
- 建立节点关系`process_node_link`

### 流程使用
- 获取工作流实例

`$workflow = new Workflow($processId);`

- 创建任务
```
$res = $workflow->create();
//return:
/***
{
process_id: 1,  // 业务流程id
process_instance_id: 22,    // 任务流程id
title: "林润审批"   // 业务名
}
**/

```
- 开始任务
```
$res = $workflow->start($processInstanceId);

//return: 返回该节点接下来流程
/***
[
    {
        id: 28,
        process_id: 1,
        process_instance_id: 22,
        node_id: 2,
        title: "征信申请",
        status: 1,
        is_completed: 0,
        is_stoped: 0,
        is_locked: 0,
        complete_at: null,
        stop_at: null,
        created_at: "2019-04-08 15:08:08",
        updated_at: "2019-04-08 15:08:08"
    }
]
**/

```
- 操作节点功能,返回下一步的流程，参数是流向下个节点的条件
```
$res = $workflow->complateAndToNextNode($nodeInstanceId, ['need_home_visit' => 1]);

// return：返回完成该节点之后的流程

[
    {
        id: 29,
        process_id: 1,
        process_instance_id: 22,
        node_id: 7,
        title: "家访签约",
        status: 1,
        is_completed: 0,
        is_stoped: 0,
        is_locked: 0,
        complete_at: null,
        stop_at: null,
        created_at: "2019-04-08 15:11:06",
        updated_at: "2019-04-08 15:11:06"
    }
]
```
- 完成任务
