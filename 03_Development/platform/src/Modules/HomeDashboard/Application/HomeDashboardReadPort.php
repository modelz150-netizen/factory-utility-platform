<?php

declare(strict_types=1);

namespace FactoryUtility\Modules\HomeDashboard\Application;

interface HomeDashboardReadPort
{
    public function read(string $scenario): HomeDashboardProjection;
}
