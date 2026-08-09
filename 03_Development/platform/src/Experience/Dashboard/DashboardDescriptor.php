<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Dashboard;

use InvalidArgumentException;

final readonly class DashboardDescriptor
{
    /** @param list<string> $regions */
    public function __construct(
        public string $id,
        public string $version,
        public string $owner,
        public string $titleKey,
        public array $regions,
    ) {
        if ($id === '' || $version === '' || $owner === '' || $titleKey === '' || $regions === []) {
            throw new InvalidArgumentException('Dashboard descriptors require identity, ownership, title, and regions.');
        }
    }
}
