<?php

declare(strict_types=1);

namespace FactoryUtility\Adapters\HomeDashboard\Fixture;

use DateTimeImmutable;
use DateTimeZone;
use FactoryUtility\Modules\HomeDashboard\Application\HomeDashboardProjection;
use FactoryUtility\Modules\HomeDashboard\Application\HomeDashboardReadPort;
use FactoryUtility\Modules\HomeDashboard\Domain\OperationalState;
use FactoryUtility\Modules\HomeDashboard\Domain\OverallHealthPolicy;
use FactoryUtility\Modules\HomeDashboard\Domain\UtilityHealthInput;
use InvalidArgumentException;

final class FixtureHomeDashboardReadAdapter implements HomeDashboardReadPort
{
    /** @var list<string> */
    public const SCENARIOS = [
        'manager_attention_default', 'all_normal', 'critical_dominance', 'multiple_abnormalities',
        'unknown_input', 'stale_data', 'partial_sources', 'health_unavailable', 'alarm_focus',
        'attention_order', 'redundancy_degraded', 'p0_degraded', 'p1_placeholders',
        'maintenance_simulated', 'maintenance_unavailable', 'single_widget_failure',
        'multiple_widget_failure', 'malformed_fixture_rejected', 'timezone_boundary',
        'locale_expansion', 'narrow_mobile', 'partial_stale_unavailable', 'widget_source_failure',
    ];

    public function __construct(private readonly OverallHealthPolicy $healthPolicy)
    {
    }

    public function read(string $scenario): HomeDashboardProjection
    {
        if (! in_array($scenario, self::SCENARIOS, true)) {
            throw new InvalidArgumentException('Unknown fixture scenario.');
        }

        $states = match ($scenario) {
            'all_normal' => array_fill(0, 8, OperationalState::Normal),
            'health_unavailable' => array_fill(0, 8, OperationalState::Unavailable),
            'unknown_input', 'stale_data', 'partial_sources', 'maintenance_unavailable', 'partial_stale_unavailable' => [OperationalState::Unknown, OperationalState::Stale, OperationalState::Unavailable, OperationalState::Normal, OperationalState::Warning, OperationalState::Normal, OperationalState::Unknown, OperationalState::Normal],
            default => [OperationalState::Critical, OperationalState::Warning, OperationalState::Normal, OperationalState::Normal, OperationalState::Warning, OperationalState::Normal, OperationalState::Stale, OperationalState::Normal],
        };

        $inputs = [];
        foreach (OverallHealthPolicy::UTILITY_ORDER as $index => $key) {
            $inputs[] = new UtilityHealthInput($key, $states[$index], $states[$index] !== OperationalState::Stale);
        }

        return new HomeDashboardProjection(
            $scenario,
            true,
            new DateTimeImmutable('2026-08-09T14:20:00+07:00', new DateTimeZone('Asia/Ho_Chi_Minh')),
            'Asia/Ho_Chi_Minh',
            $this->healthPolicy->aggregate($inputs),
            ['criticalCount' => 2, 'warningCount' => 5, 'unacknowledgedCount' => 3, 'latestMajorEvent' => 'fixture.electrical.feed_a', 'ageSeconds' => 2520, 'utilityKey' => 'electrical'],
            [
                ['rank' => 1, 'severity' => 'critical', 'utilityKey' => 'electrical', 'conditionKey' => 'fixture.condition.feed', 'ageSeconds' => 2520, 'reliabilityImpact' => 'redundancy_degraded', 'attentionCategory' => 'management_action'],
                ['rank' => 2, 'severity' => 'warning', 'utilityKey' => 'cda', 'conditionKey' => 'fixture.condition.pressure', 'ageSeconds' => 5100, 'reliabilityImpact' => 'availability_at_risk', 'attentionCategory' => 'engineering_review'],
            ],
            array_map(static fn (string $key, int $order): array => [
                'utilityKey' => $key,
                'displayOrder' => $order + 1,
                'state' => $states[$order]->value,
                'freshness' => $states[$order] === OperationalState::Stale ? 'stale' : 'fresh',
                'representativeValue' => null,
                'representativeUnitKey' => null,
                'representativeValueState' => 'unavailable',
            ], OverallHealthPolicy::UTILITY_ORDER, array_keys(OverallHealthPolicy::UTILITY_ORDER)),
            [
                ['key' => 'utility_availability', 'value' => '99.2', 'unit' => 'percent', 'state' => 'warning'],
                ['key' => 'active_abnormalities', 'value' => '7', 'unit' => 'count', 'state' => 'critical'],
                ['key' => 'major_equipment_availability', 'value' => '96.8', 'unit' => 'percent', 'state' => 'warning'],
                ['key' => 'data_freshness', 'value' => '94.1', 'unit' => 'percent', 'state' => 'stale'],
            ],
            [['severity' => 'critical', 'utilityKey' => 'electrical', 'type' => 'redundancy_degraded', 'ageSeconds' => 2520]],
            ['authority' => in_array($scenario, ['partial_stale_unavailable', 'maintenance_unavailable'], true) ? 'unavailable' : 'simulated', 'pmDue' => 4, 'overduePm' => 1, 'openCorrectiveActions' => 3],
            [
                ['key' => 'energy_consumption', 'value' => 'simulated', 'state' => 'simulated'],
                ['key' => 'water_consumption', 'value' => null, 'state' => 'unavailable'],
            ],
        );
    }
}
