<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Dashboard;

final readonly class WidgetProjection
{
    /** @param array<string, scalar|null> $content */
    public function __construct(
        public ViewState $state,
        public string $labelKey,
        public array $content,
        public ?string $source = null,
        public ?string $observedAt = null,
        public ?string $freshness = null,
        public bool $simulated = false,
        public ?string $correlationId = null,
    ) {
    }
}
