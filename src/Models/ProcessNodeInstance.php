<?php
/**
 * Created by PhpStorm.
 * User: sentiger
 * Date: 2019/4/2
 * Time: 2:53 PM
 */

namespace Yiche\Workflow\Models;


use Illuminate\Database\Eloquent\Model;

class ProcessNodeInstance extends Model
{
    protected $table = 'process_node_instance';

    public function node()
    {
        return $this->belongsTo(ProcessNode::class);
    }
}