<?php

declare(strict_types=1);

namespace FactoryUtility\Modules\Dashboard\Application;

interface DashboardReadPort
{
    /** @return array<string, scalar|null> */
    public function read(string $widgetId): array;
}
