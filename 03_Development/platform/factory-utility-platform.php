<?php
/**
 * Plugin Name: Factory Utility Platform
 * Description: Composition root for the Factory Utility Platform modular monolith.
 * Version: 1.0.0
 * Requires PHP: 8.2
 */

declare(strict_types=1);

if (! defined('ABSPATH')) {
    exit;
}

$autoload = __DIR__ . '/vendor/autoload.php';

if (! is_file($autoload)) {
    return;
}

require $autoload;

$module = new FactoryUtility\Adapters\WordPress\WordPressIntegrationModule(__FILE__);

if (function_exists('register_activation_hook')) {
    register_activation_hook(__FILE__, [FactoryUtility\Adapters\WordPress\PluginLifecycle::class, 'activate']);
    register_deactivation_hook(__FILE__, [FactoryUtility\Adapters\WordPress\PluginLifecycle::class, 'deactivate']);
}

FactoryUtility\Platform\Bootstrap\Plugin::fromModules($module)->boot();
