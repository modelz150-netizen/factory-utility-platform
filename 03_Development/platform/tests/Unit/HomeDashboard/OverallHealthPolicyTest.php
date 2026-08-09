<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Unit\HomeDashboard;

use FactoryUtility\Modules\HomeDashboard\Domain\OperationalState;
use FactoryUtility\Modules\HomeDashboard\Domain\OverallHealthPolicy;
use FactoryUtility\Modules\HomeDashboard\Domain\UtilityHealthInput;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

final class OverallHealthPolicyTest extends TestCase
{
    /** @return iterable<string, array{list<OperationalState>, OperationalState}> */
    public static function precedenceCases(): iterable
    {
        yield 'normal only' => [array_fill(0, 8, OperationalState::Normal), OperationalState::Normal];
        yield 'critical dominates warning' => [[OperationalState::Warning, OperationalState::Critical, ...array_fill(0, 6, OperationalState::Normal)], OperationalState::Critical];
        yield 'warning dominates stale' => [[OperationalState::Warning, OperationalState::Stale, ...array_fill(0, 6, OperationalState::Normal)], OperationalState::Warning];
        yield 'all unavailable' => [array_fill(0, 8, OperationalState::Unavailable), OperationalState::Unavailable];
        yield 'one unavailable is unknown' => [[OperationalState::Unavailable, ...array_fill(0, 7, OperationalState::Normal)], OperationalState::Unknown];
        yield 'unknown before stale' => [[OperationalState::Unknown, OperationalState::Stale, ...array_fill(0, 6, OperationalState::Normal)], OperationalState::Unknown];
        yield 'stale before normal' => [[OperationalState::Stale, ...array_fill(0, 7, OperationalState::Normal)], OperationalState::Stale];
    }

    /** @param list<OperationalState> $states */
    #[DataProvider('precedenceCases')]
    public function testFailSafePrecedence(array $states, OperationalState $expected): void
    {
        $inputs = [];
        foreach (OverallHealthPolicy::UTILITY_ORDER as $index => $key) {
            $inputs[] = new UtilityHealthInput($key, $states[$index], $states[$index] !== OperationalState::Stale);
        }

        self::assertSame($expected, (new OverallHealthPolicy())->aggregate($inputs)->state);
    }

    public function testMissingContributorIsPartialAndCannotAppearNormal(): void
    {
        $projection = (new OverallHealthPolicy())->aggregate([
            new UtilityHealthInput('electrical', OperationalState::Normal),
        ]);

        self::assertSame(OperationalState::Unknown, $projection->state);
        self::assertTrue($projection->partial);
        self::assertSame(7, $projection->affectedCount());
    }

    public function testStaleCriticalRetainsSeverityAndLimitation(): void
    {
        $inputs = array_map(static fn (string $key): UtilityHealthInput => new UtilityHealthInput($key, OperationalState::Normal), OverallHealthPolicy::UTILITY_ORDER);
        $inputs[0] = new UtilityHealthInput('electrical', OperationalState::Critical, fresh: false);
        $projection = (new OverallHealthPolicy())->aggregate($inputs);

        self::assertSame(OperationalState::Critical, $projection->state);
        self::assertTrue($projection->stale);
    }
}
