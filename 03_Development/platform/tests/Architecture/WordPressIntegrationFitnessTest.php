<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Architecture;

use PHPUnit\Framework\TestCase;

final class WordPressIntegrationFitnessTest extends TestCase
{
    private const ROOT = __DIR__ . '/../..';

    public function testPluginMetadataAndLifecycleAreVersioned(): void
    {
        $entry = (string) file_get_contents(self::ROOT . '/factory-utility-platform.php');
        self::assertStringContainsString('Version: 1.0.0', $entry);
        self::assertStringContainsString('register_activation_hook', $entry);
        self::assertStringContainsString('register_deactivation_hook', $entry);
        self::assertFileExists(self::ROOT . '/uninstall.php');
        self::assertFileExists(self::ROOT . '/build-manifest.json');
    }

    public function testRouteDeliveryChecksAuthenticationAndCapabilityBeforeFixturePolicy(): void
    {
        $source = (string) file_get_contents(self::ROOT . '/src/Adapters/WordPress/WordPressRouteDelivery.php');
        $authentication = strpos($source, 'is_user_logged_in');
        $capability = strpos($source, 'current_user_can');
        $fixture = strpos($source, 'permitsFixtures');
        self::assertIsInt($authentication);
        self::assertIsInt($capability);
        self::assertIsInt($fixture);
        self::assertLessThan($capability, $authentication);
        self::assertLessThan($fixture, $capability);
    }

    public function testNoRoleAssignmentDatabaseOrExternalIntegrationIsIntroduced(): void
    {
        $source = '';
        foreach (glob(self::ROOT . '/src/Adapters/WordPress/*.php') ?: [] as $file) {
            $source .= (string) file_get_contents($file);
        }
        foreach (['add_cap(', 'add_role(', '$wpdb', 'dbDelta(', 'SCADA', 'Gemma', 'curl_'] as $prohibited) {
            self::assertStringNotContainsString($prohibited, $source);
        }
    }

    public function testAssetsAreReferencedOnlyFromMatchedRouteDelivery(): void
    {
        $source = (string) file_get_contents(self::ROOT . '/src/Adapters/WordPress/WordPressRouteDelivery.php');
        self::assertStringContainsString('ApplicationRoute::matches', $source);
        self::assertStringContainsString("'/tests/Fixtures/HomeDashboard/index.html'", $source);
        self::assertStringNotContainsString('wp_enqueue_scripts', $source);
    }
}
