<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Dashboard;

final readonly class RenderedWidget
{
    public function __construct(
        public string $id,
        public string $region,
        public string $markup,
        public ViewState $state,
        public ?string $correlationId,
    ) {
    }
}
