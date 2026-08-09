<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Experience\Dashboard;

use PHPUnit\Framework\TestCase;

final class DashboardFixtureContractTest extends TestCase
{
    private const ROOT = __DIR__ . '/../../..';

    public function testAllLocaleResourcesHaveTheEnglishKeys(): void
    {
        $fallback = $this->dictionary('en-US');
        foreach (['ko-KR', 'vi-VN'] as $locale) {
            self::assertSame(array_keys($fallback), array_keys($this->dictionary($locale)), "{$locale} dictionary keys differ from en-US.");
        }
    }

    public function testFixtureProvidesShellSelectorAndTruthfulStates(): void
    {
        $html = (string) file_get_contents(self::ROOT . '/tests/Fixtures/DashboardFramework/index.html');
        self::assertStringContainsString('<header', $html);
        self::assertStringContainsString('<nav', $html);
        self::assertStringContainsString('<main', $html);
        self::assertStringContainsString('<footer', $html);
        self::assertStringContainsString('한국어', $html);
        self::assertStringContainsString('Tiếng Việt', $html);
        self::assertStringContainsString('English', $html);
        foreach (['simulated', 'stale', 'unavailable', 'error'] as $state) {
            self::assertMatchesRegularExpression('/data-(?:state|status)="' . $state . '"/', $html);
        }
    }

    public function testFixtureIsIsolatedAndContainsNoProductionData(): void
    {
        $fixture = (string) file_get_contents(self::ROOT . '/tests/Fixtures/DashboardFramework/index.html')
            . (string) file_get_contents(self::ROOT . '/tests/Fixtures/DashboardFramework/fixture.js');
        self::assertStringContainsString('Simulated', (string) file_get_contents(self::ROOT . '/assets/dashboard-framework/locales/en-US.json'));
        foreach (['wp_enqueue', 'wp_ajax', 'SCADA', 'fetch("http', 'authentication', 'production KPI'] as $prohibited) {
            self::assertStringNotContainsString($prohibited, $fixture);
        }
    }

    public function testFrameworkAssetBudgets(): void
    {
        $css = (string) file_get_contents(self::ROOT . '/assets/dashboard-framework/css/framework.css');
        $js = (string) file_get_contents(self::ROOT . '/tests/Fixtures/DashboardFramework/fixture.js');
        $compressedCss = gzencode($css);
        $compressedJs = gzencode($js);
        self::assertNotFalse($compressedCss);
        self::assertNotFalse($compressedJs);
        self::assertLessThanOrEqual(20 * 1024, strlen($compressedCss));
        self::assertLessThanOrEqual(30 * 1024, strlen($compressedJs));
    }

    /** @return array<string, string> */
    private function dictionary(string $locale): array
    {
        $decoded = json_decode((string) file_get_contents(self::ROOT . "/assets/dashboard-framework/locales/{$locale}.json"), true, 512, JSON_THROW_ON_ERROR);
        self::assertIsArray($decoded);
        $dictionary = [];
        foreach ($decoded as $key => $value) {
            self::assertIsString($key);
            self::assertIsString($value);
            $dictionary[$key] = $value;
        }

        return $dictionary;
    }
}
