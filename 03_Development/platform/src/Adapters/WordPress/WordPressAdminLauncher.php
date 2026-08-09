<?php

declare(strict_types=1);

namespace FactoryUtility\Adapters\WordPress;

final class WordPressAdminLauncher
{
    public function register(): void
    {
        if (! function_exists('add_menu_page')) {
            return;
        }

        add_menu_page(
            'Factory Utility Platform',
            'Factory Utility',
            ApplicationRoute::CAPABILITY,
            'factory-utility-platform',
            [$this, 'render'],
            'dashicons-dashboard',
            30,
        );
    }

    public function render(): void
    {
        if (! function_exists('current_user_can') || ! current_user_can(ApplicationRoute::CAPABILITY)) {
            return;
        }

        $environmentValue = function_exists('wp_get_environment_type') ? wp_get_environment_type() : null;
        $environment = RuntimeEnvironment::fromWordPress(is_string($environmentValue) ? $environmentValue : 'production');
        $urlValue = function_exists('home_url') ? home_url('/factory-utility/') : null;
        $url = is_string($urlValue) ? $urlValue : '/factory-utility/';
        $escapedValue = function_exists('esc_url') ? esc_url($url) : null;
        $safeUrl = is_string($escapedValue) ? $escapedValue : htmlspecialchars($url, ENT_QUOTES, 'UTF-8');

        echo '<div class="wrap"><h1>Factory Utility Platform</h1><p><strong>Version:</strong> 1.0.0</p><p><strong>Environment:</strong> '
            . htmlspecialchars($environment->value, ENT_QUOTES, 'UTF-8')
            . '</p><p><strong>Application route:</strong> /factory-utility/</p><p><strong>Fixture policy:</strong> '
            . ($environment->permitsFixtures() ? 'allowed for non-production review' : 'prohibited / fail-closed')
            . '</p><p><a class="button button-primary" href="' . $safeUrl . '">Open Factory Utility Platform</a></p></div>';
    }
}
