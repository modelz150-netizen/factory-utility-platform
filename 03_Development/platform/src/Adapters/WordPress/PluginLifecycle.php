<?php

declare(strict_types=1);

namespace FactoryUtility\Adapters\WordPress;

final class PluginLifecycle
{
    public static function activate(): void
    {
        self::registerRewrite();
        if (function_exists('update_option')) {
            update_option('factory_utility_platform_version', '1.0.0', false);
        }
        if (function_exists('flush_rewrite_rules')) {
            flush_rewrite_rules(false);
        }
    }

    public static function deactivate(): void
    {
        if (function_exists('flush_rewrite_rules')) {
            flush_rewrite_rules(false);
        }
    }

    public static function registerRewrite(): void
    {
        if (function_exists('add_rewrite_rule')) {
            add_rewrite_rule('^factory-utility/?$', 'index.php?factory_utility_route=home', 'top');
        }
    }
}
