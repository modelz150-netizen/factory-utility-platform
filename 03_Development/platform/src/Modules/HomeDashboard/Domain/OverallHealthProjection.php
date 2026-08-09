<?php

declare(strict_types=1);

namespace FactoryUtility\Modules\HomeDashboard\Domain;

final readonly class OverallHealthProjection
{
    /** @param list<string> $affectedUtilityKeys */
    public function __construct(
        public OperationalState $state,
        public array $affectedUtilityKeys,
        public bool $partial,
        public bool $stale,
        public string $policyVersion = 'overall-health/1.0',
    ) {
    }

    public function affectedCount(): int
    {
        return count($this->affectedUtilityKeys);
    }
}
