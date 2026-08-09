<?php

declare(strict_types=1);

namespace FactoryUtility\Adapters\WordPress;

final class ApplicationRoute
{
    public const NAME = 'factory_utility_home';
    public const QUERY_VAR = 'factory_utility_route';
    public const PATH = 'factory-utility';
    public const CAPABILITY = 'view_factory_utility_dashboard';

    public static function matches(mixed $value): bool
    {
        return $value === 'home';
    }
}
