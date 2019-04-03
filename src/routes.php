<?php
Route::get('yiche/workflow/all', \Yiche\Workflow\Http\Controllers\WorkflowController::class . '@index');
Route::get('yiche/workflow/test', \Yiche\Workflow\Http\Controllers\WorkflowController::class . '@test');