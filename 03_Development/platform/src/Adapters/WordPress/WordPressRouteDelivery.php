<?php

declare(strict_types=1);

namespace FactoryUtility\Adapters\WordPress;

final readonly class WordPressRouteDelivery
{
    public function __construct(private string $pluginFile)
    {
    }

    /**
     * @param list<string> $variables
     * @return list<string>
     */
    public function queryVars(array $variables): array
    {
        if (! in_array(ApplicationRoute::QUERY_VAR, $variables, true)) {
            $variables[] = ApplicationRoute::QUERY_VAR;
        }

        return $variables;
    }

    public function dispatch(): void
    {
        if (! function_exists('get_query_var') || ! ApplicationRoute::matches(get_query_var(ApplicationRoute::QUERY_VAR))) {
            return;
        }

        if (! function_exists('is_user_logged_in') || ! is_user_logged_in()) {
            $this->respond(401, $this->statusPage('Authentication required', 'Sign in with an authorized WordPress account.'));
        }

        if (! function_exists('current_user_can') || ! current_user_can(ApplicationRoute::CAPABILITY)) {
            $this->respond(403, $this->statusPage('Access denied', 'The required capability is view_factory_utility_dashboard.'));
        }

        $environmentValue = function_exists('wp_get_environment_type') ? wp_get_environment_type() : null;
        $environment = RuntimeEnvironment::fromWordPress(is_string($environmentValue) ? $environmentValue : 'production');

        if (! $environment->permitsFixtures()) {
            $this->respond(503, $this->statusPage('Operational source unavailable', 'Production fixture fallback is prohibited. No simulated data was loaded.'));
        }

        $fixture = dirname($this->pluginFile) . '/tests/Fixtures/HomeDashboard/index.html';
        $markup = is_file($fixture) ? (string) file_get_contents($fixture) : '';
        if ($markup === '') {
            $this->respond(503, $this->statusPage('Application fixture unavailable', 'The non-production review surface could not be loaded.'));
        }

        $baseValue = function_exists('plugin_dir_url') ? plugin_dir_url($this->pluginFile) : null;
        $base = is_string($baseValue) ? $baseValue : '';
        $markup = str_replace('../../../assets/', $base . 'assets/', $markup);
        $markup = str_replace('src="fixture.js"', 'src="' . $base . 'tests/Fixtures/HomeDashboard/fixture.js"', $markup);
        $this->respond(200, $markup);
    }

    private function statusPage(string $title, string $message): string
    {
        return '<!doctype html><html lang="en-US"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>'
            . htmlspecialchars($title, ENT_QUOTES, 'UTF-8')
            . '</title><style>body{margin:0;font:16px system-ui;background:#f4f6f8;color:#17202a}.box{max-width:44rem;margin:12vh auto;padding:2rem;border:1px solid #aab4bf;background:#fff}strong{display:inline-block;padding:.35rem .6rem;border:2px solid #6136c9}h1{font-size:2rem}</style></head><body><main class="box"><strong>Factory Utility Platform</strong><h1>'
            . htmlspecialchars($title, ENT_QUOTES, 'UTF-8') . '</h1><p>'
            . htmlspecialchars($message, ENT_QUOTES, 'UTF-8')
            . '</p><p>Request correlation: wp-integration-safe-response</p></main></body></html>';
    }

    private function respond(int $status, string $markup): never
    {
        if (function_exists('status_header')) {
            status_header($status);
        }
        if (function_exists('nocache_headers')) {
            nocache_headers();
        }
        header('Content-Type: text/html; charset=UTF-8');
        echo $markup;
        exit;
    }
}
