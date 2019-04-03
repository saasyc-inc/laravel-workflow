<?php
/**
 * Created by PhpStorm.
 * User: sentiger
 * Date: 2019/4/2
 * Time: 3:57 PM
 */

namespace Yiche\Workflow\Exception;


class Exception extends \Exception
{
    /**
     * @var  int 流程已经开始
     */
    const PROCESS_STARTING = 1001;

    /**
     * @var int 该流程已经完成
     */
    const PROCESS_COMPLATED = 1002;

    /**
     * @var int 参数错误
     */
    const PARAMETER_ERR = 2001;


    public function __construct($message = "", $code = 0, Throwable $previous = null)
    {
        parent::__construct($message, $code, $previous);
    }
}