<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Shell;

final readonly class NavigationDestination
{
    public function __construct(
        public string $id,
        public string $route,
        public string $labelKey,
        public string $owner,
        public bool $visible,
        public string $readiness = 'available',
    ) {
    }
}
