<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Experience;

use PHPUnit\Framework\TestCase;

final class HomeDashboardFixtureContractTest extends TestCase
{
    private const ROOT = __DIR__ . '/../..';

    public function testFixtureContainsRequiredRegionsLocalesAndTruthDisclosure(): void
    {
        $html = (string) file_get_contents(self::ROOT . '/tests/Fixtures/HomeDashboard/index.html');
        foreach (['overall', 'alarms', 'attention', 'utilities', 'kpis', 'risk', 'maintenance', 'p1'] as $required) {
            self::assertStringContainsString($required, $html);
        }
        foreach (['한국어', 'Tiếng Việt', 'English', 'SIMULATED / FIXTURE', 'Asia/Ho_Chi_Minh'] as $required) {
            self::assertStringContainsString($required, $html);
        }
    }

    public function testFixtureImplementsRequiredReviewScenarios(): void
    {
        $fixture = (string) file_get_contents(self::ROOT . '/tests/Fixtures/HomeDashboard/fixture.js');
        foreach (['manager_attention_default', 'partial_stale_unavailable', 'widget_source_failure'] as $scenario) {
            self::assertStringContainsString($scenario, $fixture);
        }
        foreach (['ko-KR', 'vi-VN', 'en-US'] as $locale) {
            self::assertStringContainsString($locale, $fixture);
        }
    }

    public function testAssetsRemainInsideApprovedBudgets(): void
    {
        $css = gzencode((string) file_get_contents(self::ROOT . '/assets/home-dashboard/css/home-dashboard.css'));
        $js = gzencode((string) file_get_contents(self::ROOT . '/tests/Fixtures/HomeDashboard/fixture.js'));
        self::assertNotFalse($css);
        self::assertNotFalse($js);
        self::assertLessThanOrEqual(16 * 1024, strlen($css));
        self::assertLessThanOrEqual(24 * 1024, strlen($js));
    }

    public function testFixtureContainsNoExternalConnectionOrProductionRegistration(): void
    {
        $fixture = (string) file_get_contents(self::ROOT . '/tests/Fixtures/HomeDashboard/fixture.js');
        foreach (['fetch(', 'XMLHttpRequest', 'WebSocket', 'wp_ajax', 'scada://', 'password'] as $prohibited) {
            self::assertStringNotContainsString($prohibited, $fixture);
        }
    }
}
