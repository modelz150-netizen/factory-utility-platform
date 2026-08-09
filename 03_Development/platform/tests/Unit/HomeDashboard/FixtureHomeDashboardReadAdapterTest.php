<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Unit\HomeDashboard;

use FactoryUtility\Adapters\HomeDashboard\Fixture\FixtureHomeDashboardReadAdapter;
use FactoryUtility\Modules\HomeDashboard\Domain\OperationalState;
use FactoryUtility\Modules\HomeDashboard\Domain\OverallHealthPolicy;
use InvalidArgumentException;
use PHPUnit\Framework\TestCase;

final class FixtureHomeDashboardReadAdapterTest extends TestCase
{
    public function testDefaultProjectionIsSimulatedOrderedAndPlantLocal(): void
    {
        $projection = (new FixtureHomeDashboardReadAdapter(new OverallHealthPolicy()))->read('manager_attention_default');

        self::assertTrue($projection->simulated);
        self::assertSame('Asia/Ho_Chi_Minh', $projection->plantTimezone);
        self::assertSame(OperationalState::Critical, $projection->overallHealth->state);
        self::assertSame(OverallHealthPolicy::UTILITY_ORDER, array_column($projection->utilities, 'utilityKey'));
        self::assertSame([1, 2], array_column($projection->attention, 'rank'));
        self::assertCount(4, $projection->kpis);
        self::assertCount(2, $projection->p1Context);
        self::assertContains('locale_expansion', FixtureHomeDashboardReadAdapter::SCENARIOS);
        self::assertContains('narrow_mobile', FixtureHomeDashboardReadAdapter::SCENARIOS);
    }

    public function testUnknownScenarioIsRejected(): void
    {
        $this->expectException(InvalidArgumentException::class);
        (new FixtureHomeDashboardReadAdapter(new OverallHealthPolicy()))->read('production');
    }
}
