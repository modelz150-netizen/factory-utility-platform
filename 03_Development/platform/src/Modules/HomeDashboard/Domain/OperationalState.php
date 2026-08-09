<?php

declare(strict_types=1);

namespace FactoryUtility\Modules\HomeDashboard\Domain;

enum OperationalState: string
{
    case Normal = 'normal';
    case Warning = 'warning';
    case Critical = 'critical';
    case Unknown = 'unknown';
    case Stale = 'stale';
    case Unavailable = 'unavailable';
}
