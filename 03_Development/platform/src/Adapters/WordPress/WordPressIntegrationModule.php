<?php

declare(strict_types=1);

namespace FactoryUtility\Adapters\WordPress;

use FactoryUtility\Modules\Contracts\Module;

final readonly class WordPressIntegrationModule implements Module
{
    public function __construct(private string $pluginFile)
    {
    }

    public function register(): void
    {
        if (! function_exists('add_action') || ! function_exists('add_filter')) {
            return;
        }

        $delivery = new WordPressRouteDelivery($this->pluginFile);
        $admin = new WordPressAdminLauncher();

        add_action('init', [PluginLifecycle::class, 'registerRewrite']);
        add_filter('query_vars', [$delivery, 'queryVars']);
        add_action('template_redirect', [$delivery, 'dispatch']);
        add_action('admin_menu', [$admin, 'register']);
    }
}
