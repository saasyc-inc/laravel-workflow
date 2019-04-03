<?php
/**
 * Created by PhpStorm.
 * User: sentiger
 * Date: 2019/4/2
 * Time: 3:57 PM
 */

namespace Yiche\Workflow\Exception;


class ParameterException extends Exception
{
    public function __construct($message = "", $code = self::PARAMETER_ERR, Throwable $previous = null)
    {
        parent::__construct($message, $code, $previous);
    }
}