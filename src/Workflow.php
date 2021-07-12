<?php

namespace Yiche\Workflow;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\ServiceProvider;
use Yiche\Workflow\Exception\ParameterException;
use Yiche\Workflow\Exception\ProcessException;
use Yiche\Workflow\Models\Process;
use Yiche\Workflow\Models\ProcessInstance;
use Yiche\Workflow\Models\ProcessNodeInstance;
use Yiche\Workflow\Models\ProcessNodeLink;

class Workflow extends ServiceProvider
{
    /**
     * 总流程id
     * @var int
     */
    private $processId = 0;
    private $process   = null;

    public function __construct($processId)
    {
        $this->processId = $processId;

        $this->checkProcess();
    }

    /**
     * 检查process
     * @throws ParameterException
     */
    private function checkProcess()
    {
        $process = Process::find($this->processId);
        if (empty($process)) {
            throw new ParameterException('[processId]不存在');
        }
        $this->process = $process;
    }

    /**
     * 创建流程
     * @return array
     */
    public function create()
    {
        //添加任务实例
        $instanceId = ProcessInstance::insertGetId([
            'process_id'   => $this->processId,
            'title'        => $this->process->title,
            'status'       => 1,
            'is_completed' => 0,
            'is_stoped'    => 0,
        ]);

        return [
            'process_id'          => $this->processId,
            'process_instance_id' => $instanceId,
            'title'               => $this->process->title,
        ];
    }

    /**
     * 开始任务，返回当前在流程
     * @param $processInstanceId
     * @return array
     * @throws ParameterException
     * @throws ProcessException
     */
    public function start($processInstanceId)
    {
        $hasStart = ProcessNodeInstance::where('process_instance_id', $processInstanceId)->first();
        if (!empty($hasStart)) {
            throw new ProcessException('任务已经在进行中，不能再开始', ProcessException::PROCESS_STARTING);
        }
        $nodes     = $this->nextNodes($processInstanceId, 0);
        $nextNodes = [];
        foreach ($nodes as $k => $v) {
            $nodeInstanceId = $this->run($processInstanceId, $v, []);
            if ($nodeInstanceId) {
                $nodeInstanceObj = ProcessNodeInstance::with('node')->find($nodeInstanceId);
                if (!empty($nodeInstanceObj)) {
                    $nodeInstanceObj->process_id = $this->processId;
                    if (!empty($nodeInstanceObj->node)) {
                        $nodeInstanceObj->node->process_id = $this->processId;
                    }
                }
                $nextNodes[] = $nodeInstanceObj;
            }
        }
        return $nextNodes;
    }

    /**
     * 完成该节点
     * @param $nodeInstanceId
     * @param array $params
     * @return array
     * @throws ParameterException
     * @throws ProcessException
     */
    public function completeNode($nodeInstanceId, $params = [])
    {
        try {
            DB::beginTransaction();
            $nodeInstance = ProcessNodeInstance::sharedLock()->find($nodeInstanceId);
            if (empty($nodeInstance)) {
                throw new ParameterException('[node_item_id]参数错误');
            }
            if ($nodeInstance->is_completed == 1) {
                throw new ProcessException('该流程已经已经完成', ProcessException::PROCESS_COMPLATED);
            }
            ProcessNodeInstance::where('id', $nodeInstanceId)->update([
                'status'       => 2,
                'is_completed' => 1,
                'complete_at'  => date('Y-m-d H:i:s', time()),
            ]);
            DB::commit();
            return $nextNodes;
        } catch (\Throwable $exception) {
            DB::rollBack();
            throw new ProcessException($exception->getMessage());
        }
    }

    /**
     * 完成该节点，并进入下一个节点
     * @param $nodeInstanceId
     * @param array $params
     * @return array
     * @throws ParameterException
     * @throws ProcessException
     */
    public function completeAndToNextNode($nodeInstanceId, $params = [])
    {
        try {
            DB::beginTransaction();
            // 使用锁，之前发现连续点击出现错误，这个不会影响啥性能，因为自己的数据只能自己操作
            $nodeInstance = ProcessNodeInstance::sharedLock()->find($nodeInstanceId);
            if (empty($nodeInstance)) {
                throw new ParameterException('[node_item_id]参数错误');
            }
            if ($nodeInstance->is_completed == 1) {
                throw new ProcessException('该流程已经已经完成', ProcessException::PROCESS_COMPLATED);
            }
            ProcessNodeInstance::where('id', $nodeInstanceId)->update([
                'status'       => 2,
                'is_completed' => 1,
                'complete_at'  => date('Y-m-d H:i:s', time()),
            ]);
            $nextNodes = $this->toNextNode($nodeInstanceId, $params);
            DB::commit();
            return $nextNodes;
        } catch (\Throwable $exception) {
            DB::rollBack();
            throw new ProcessException($exception->getMessage());
        }
    }

    public function toProNode($nodeInstanceId)
    {
        $nodeInstance               = ProcessNodeInstance::find($nodeInstanceId);
        $nodeInstance->status       = 4;
        $nodeInstance->is_completed = 1;
        $nodeInstance->save();

        $preNode = ProcessNodeInstance::where('node_id', $nodeInstance->pre_node_id ?? -1)->first();
        if (empty($preNode)) {
            return null;
        }
        $preNodeModel                      = new ProcessNodeInstance();
        $preNodeModel->process_id          = $preNode->id;
        $preNodeModel->process_instance_id = $preNode->process_instance_id;
        $preNodeModel->node_id             = $preNode->node_id;
        $preNodeModel->pre_node_id         = $preNode->pre_node_id;
        $preNodeModel->title               = $preNode->title;
        $preNodeModel->save();
        return $preNodeModel;

    }

    /**
     * 直接到达下个流程
     * @param $nodeInstanceId
     * @param array $params
     * @return array
     * @throws ParameterException
     * @throws ProcessException
     */
    public function toNextNode($nodeInstanceId, $params = [])
    {
        $nodeInstance = ProcessNodeInstance::find($nodeInstanceId);
        if (empty($nodeInstance)) {
            throw new ParameterException('[node_item_id]参数错误');
        }
        $nodes     = $this->nextNodes($nodeInstance->process_instance_id, $nodeInstance->node_id);
        $nextNodes = [];
        foreach ($nodes as $k => $v) {
            $nodeInstanceIds = $this->run($nodeInstance->process_instance_id, $v, $params, $nodeInstance->node_id);
            if (!is_array($nodeInstanceIds)) {
                $nodeInstanceIds = [$nodeInstanceIds];
            }
            foreach ($nodeInstanceIds as $k => $nodeInstanceId) {
                if ($nodeInstanceId) {
                    $res = ProcessNodeInstance::with('node')->find($nodeInstanceId);
                    if ($res) {
                        $res->process_id = $this->processId;
                        if (!empty($res->node)) {
                            $res->node->process_id = $this->processId;
                        }
                        $nextNodes[] = $res;
                    }
                }
            }
        }
        return $nextNodes;
    }

    /**
     * 查找当前任务的下个走向节点
     * @param     $processInstanceId
     * @param int $nodeId
     * @return array
     * @throws ParameterException
     */
    public function nextNodes($processInstanceId, $nodeId = 0)
    {
        $processInstance = ProcessInstance::find($processInstanceId);
        if (empty($processInstance)) {
            throw new ParameterException('[process_instance_id]错误');
        }
        if ($nodeId == 0) {
            $where = [
                'process_id' => $processInstance->process_id,
                'prev_id'    => 0,
            ];
        } else {
            $where = [
                'process_id' => $processInstance->process_id,
                'current_id' => $nodeId,
            ];
        }
        $links = ProcessNodeLink::where($where)->with('next_node')->get()->toArray();
        return $links;
        $linksMap = [];
        foreach ($links as $k => $v) {
            $linksMap[$v['next_id']] = $v['next_node'];
        }
        return array_values($linksMap);
    }

    /**
     * 查找当前任务的上个走向节点
     * @param     $processInstanceId
     * @param int $nodeId
     * @return array
     * @throws ParameterException
     */
    public function prevNodes($processInstanceId, $nodeId = 0)
    {
        $processInstance = ProcessInstance::find($processInstanceId);
        if (empty($processInstance)) {
            throw new ParameterException('[process_instance_id]错误');
        }
        if ($nodeId == 0) {
            $links = [];
        } else {
            $links = ProcessNodeLink::where([
                'process_id' => $processInstance->process_id,
                'current_id' => $nodeId,
            ])->with('prev_node')->get()->toArray();

        }
        $linksMap = [];
        foreach ($links as $k => $v) {
            $linksMap[$v['prev_id']] = $v['prev_node'];
        }
        return array_values($linksMap);
    }

    /**
     * 运行任务
     * @param $processInstanceId
     * @param $node
     * @param $data
     * @param $preNodeId 上个节点ID
     * @return int
     */
    private function run($processInstanceId, $nodeLink, $data, $preNodeId = 0)
    {
        $nodeType = $nodeLink['next_node']['node_type'] ?? '';
        switch ($nodeType) {
            case 'event':              //事件：包括空开始事件、空结束事件、终止结束事件
                $this->_runEvent($processInstanceId, $nodeLink, $data);
                break;
            case 'gateway':             //网关：包括唯一网关、并行网关、包含网关
                return $this->_runGateway($processInstanceId, $nodeLink, $data);
                break;
            case 'task':                //任务，包括人工任务、服务任务、脚本任务、手工任务、接收任务
                return $this->_runTask($processInstanceId, $nodeLink, $data, $preNodeId);
                break;
            case 'end' :
                $this->_runEnd($processInstanceId, $nodeLink, $data);
            default:
                break;
        }
        // todo 通知项目进程下个节点
        return 0;
    }

    /**
     * 执行任务
     * @param       $processInstanceId
     * @param       $node
     * @param array $data
     * @return mixed
     */
    private function _runTask($processInstanceId, $nodeLink, $data = [], $proNodeId = 0)
    {
        $node                      = $nodeLink['next_node'];
        $param                     = [
            'process_id'          => $node['process_id'],
            'process_instance_id' => $processInstanceId,
            'node_id'             => $node['id'],
            'pre_node_id'         => $proNodeId,
            'title'               => $node['title'],
        ];
        $nodeInstanceId            = ProcessNodeInstance::insertGetId($param);
        $param['node_instance_id'] = $nodeInstanceId;
        return $nodeInstanceId;
    }


    private function _runGateway($processInstanceId, $nodeLink, $data = [])
    {
        $res    = [];
        $nodeId = $nodeLink['next_node']['id'];
        $next   = $this->nextNodes($processInstanceId, $nodeId);
        foreach ($next as $k => $v) {
            if ($this->_matchCondition($v, $data)) {
                $res[] = $this->run($processInstanceId, $v, $data, $nodeLink['current_id']);
            }
        }
        return $res;
    }

    //结束流程
    private function _runEnd($processInstanceId, $node, $data)
    {
        ProcessNodeInstance::where('id', $processInstanceId)->update([
            'is_stoped' => 1,
            'stop_at'   => date('Y-m-d H:i:s')
        ]);
    }

    private function _runEvent($processInstanceId, $node, $data)
    {
//        $next = $this->nextNodes($processInstanceId, $node->id);
//        foreach ($next as $k => $v) {
//            $this->run($processInstanceId, $this->detail($v->item_id), $data);
//        }
    }

    /**
     * node条件比较
     * @param $node
     * @param $data
     * @return mixed
     */
    private function _matchCondition($node, $data)
    {
        extract($data); //数组转变量
        @eval('$r = ' . $node['condition'] . ' ;'); //执行规则,@防止变量未定义
        return $r;
    }
}
