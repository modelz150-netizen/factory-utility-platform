<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Shell;

final readonly class RouteResolver
{
    /** @param list<NavigationDestination> $destinations */
    public function __construct(private array $destinations)
    {
    }

    public function resolve(string $route): ?NavigationDestination
    {
        foreach ($this->destinations as $destination) {
            if ($destination->route === $route && $destination->visible) {
                return $destination;
            }
        }

        return null;
    }
}
