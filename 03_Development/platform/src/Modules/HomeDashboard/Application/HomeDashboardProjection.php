<?php

declare(strict_types=1);

namespace FactoryUtility\Modules\HomeDashboard\Application;

use DateTimeImmutable;
use FactoryUtility\Modules\HomeDashboard\Domain\OverallHealthProjection;

final readonly class HomeDashboardProjection
{
    /**
     * @param list<array<string, mixed>> $attention
     * @param list<array<string, mixed>> $utilities
     * @param list<array<string, mixed>> $kpis
     * @param list<array<string, mixed>> $reliabilityRisks
     * @param array<string, mixed> $alarmSummary
     * @param array<string, mixed> $maintenance
     * @param list<array<string, mixed>> $p1Context
     */
    public function __construct(
        public string $scenario,
        public bool $simulated,
        public DateTimeImmutable $asOf,
        public string $plantTimezone,
        public OverallHealthProjection $overallHealth,
        public array $alarmSummary,
        public array $attention,
        public array $utilities,
        public array $kpis,
        public array $reliabilityRisks,
        public array $maintenance,
        public array $p1Context,
    ) {
    }
}
