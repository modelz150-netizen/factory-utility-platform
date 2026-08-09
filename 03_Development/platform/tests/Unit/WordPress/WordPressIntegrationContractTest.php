<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Unit\WordPress;

use FactoryUtility\Adapters\WordPress\ApplicationRoute;
use FactoryUtility\Adapters\WordPress\RuntimeEnvironment;
use FactoryUtility\Adapters\WordPress\WordPressIntegrationModule;
use PHPUnit\Framework\TestCase;

final class WordPressIntegrationContractTest extends TestCase
{
    public function testStableRouteAndCapabilityContracts(): void
    {
        self::assertSame('factory_utility_home', ApplicationRoute::NAME);
        self::assertSame('factory_utility_route', ApplicationRoute::QUERY_VAR);
        self::assertSame('factory-utility', ApplicationRoute::PATH);
        self::assertSame('view_factory_utility_dashboard', ApplicationRoute::CAPABILITY);
        self::assertTrue(ApplicationRoute::matches('home'));
        self::assertFalse(ApplicationRoute::matches('utility-detail'));
    }

    public function testFixturePolicyIsFailClosedInProduction(): void
    {
        self::assertTrue(RuntimeEnvironment::fromWordPress('development')->permitsFixtures());
        self::assertTrue(RuntimeEnvironment::fromWordPress('local')->permitsFixtures());
        self::assertTrue(RuntimeEnvironment::fromWordPress('staging')->permitsFixtures());
        self::assertFalse(RuntimeEnvironment::fromWordPress('production')->permitsFixtures());
        self::assertFalse(RuntimeEnvironment::fromWordPress('unexpected')->permitsFixtures());
    }

    public function testModuleSafelyDoesNothingOutsideWordPress(): void
    {
        self::expectNotToPerformAssertions();
        (new WordPressIntegrationModule('/fixture/plugin.php'))->register();
    }
}
