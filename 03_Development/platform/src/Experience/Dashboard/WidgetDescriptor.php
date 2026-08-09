<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Dashboard;

use InvalidArgumentException;

final readonly class WidgetDescriptor
{
    /** @param list<ViewState> $supportedStates */
    public function __construct(
        public string $id,
        public string $version,
        public string $owner,
        public string $renderer,
        public string $region,
        public array $supportedStates,
        public int $order = 0,
    ) {
        if (preg_match('/^[a-z][a-z0-9.-]+$/', $id) !== 1 || $version === '' || $owner === '' || $renderer === '' || $region === '') {
            throw new InvalidArgumentException('Widget descriptors require a stable ID, version, owner, renderer, and region.');
        }
    }
}
