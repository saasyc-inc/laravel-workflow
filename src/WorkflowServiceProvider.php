<?php

namespace Yiche\Workflow;

use Illuminate\Foundation\Application;
use Illuminate\Support\ServiceProvider;

class WorkflowServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        // 加载路由
        $this->loadRoutesFrom(__DIR__ . '/routes.php');
        $this->loadViewsFrom(__DIR__ . '/resources/views', 'workflow');

        $this->commands([
            RegionInstall::class
        ]);

        $this->publishes([
            __DIR__ . '/resources/assets' => public_path('vendor/yiche/workflow'),
        ], 'workflow');
    }

    /**
     * Register the application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->singleton('yc-workflow', function (Application $app, $param) {
            return new Workflow($param['processId']);
        });
    }
}
