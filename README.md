# 流程引擎使用V1
## 安装
- composer require yiche/workflow:dev-master
- php artisan vendor:publish --tag=workflow --force
- php artisan yiche:workflow-install
## 使用
### 建立独立流程
- 初始化流程线`process`
- 建立节点，网关等`process_node`
- 建立节点关系`process_node_link`

### 流程使用
- 默认流程路由
http://xxx//yiche/workflow/all 

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

# v1.9
> 这个是个大版本，与之前的版本不兼容

- 修改节点条件到link表中添加，优化多条件同个节点
- 新增锁操作，防止并发出现问题
- 新增直接到达下个节点
```
$service->toNextNode($nodeInstanceId,$params);
```

- 新增回退上个节点
```
$preNode = $service->toProNode(6);
```

- 新增去任意节点，无需配置流程
```
// 直接从当前的节点，跳转到指定的节点
$nextList = $service->toNode(4, 'yhzxcx');
dd($nextList);
```
