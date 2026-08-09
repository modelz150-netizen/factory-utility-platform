<?php

declare(strict_types=1);

namespace FactoryUtility\Modules\HomeDashboard\Domain;

final readonly class UtilityHealthInput
{
    public function __construct(
        public string $utilityKey,
        public OperationalState $state,
        public bool $fresh = true,
        public bool $trustworthy = true,
    ) {
    }
}
