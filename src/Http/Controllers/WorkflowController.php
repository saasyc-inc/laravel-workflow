<?php

namespace Yiche\Workflow\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yiche\Workflow\Models\ProcessNode;
use Yiche\Workflow\Models\ProcessNodeLink;
use Yiche\Workflow\Workflow;

class WorkflowController extends Controller
{
    public function index(Request $request)
    {
        $processId = $request->input('process_id', 1);

        $nodeList = ProcessNode::where([
            'process_id' => $processId
        ])->get()->toArray();

        $itemMap = [];
        foreach ($nodeList as $k => $v) {
            $itemMap[$v['id']]             = $v;
            $itemMap[$v['id']]['title_id'] = $v['title'] . '[' . $v['id'] . ']' . '[' . $v['node_id'] . ']';
        }

        $nodeLinkList = ProcessNodeLink::where([
            'process_id' => $processId
        ])->get()->toArray();
        return view('workflow::index', [
            'item_map'       => $itemMap,
            'links'          => $nodeLinkList,
            'show_condition' => true
        ]);
    }

    public function test()
    {
        $workflow = new Workflow(1);
//        return $workflow->create();
//        return $workflow->start(2);
        return $workflow->complateAndToNextNode(19, [
            'pass_status' => 2
        ]);
//        $workflow = app('yc-workflow', [
//            'processId' => 1
//        ]);
//        return $workflow->create();
//        return $workflow->start(1);
//        return $workflow->complateAndToNextNode(4, [
//            'pass_status' => 2
//        ]);
//        return $workflow->complateAndToNextNode(26, [
//            'need_home_visit' => 1,
//            'visit_status'    => 1,
//        ]);

    }
}