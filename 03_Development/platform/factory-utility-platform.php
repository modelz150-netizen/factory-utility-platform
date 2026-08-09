<?php
/**
 * Plugin Name: Factory Utility Platform
 * Description: Composition root for the Factory Utility Platform modular monolith.
 * Version: 0.1.0
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

FactoryUtility\Platform\Bootstrap\Plugin::empty()->boot();
