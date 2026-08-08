<?php

declare(strict_types=1);

namespace FactoryUtility\Platform\Bootstrap;

use FactoryUtility\Modules\Contracts\Module;

/**
 * Composition root for approved Platform modules.
 */
final class Plugin
{
    /** @param list<Module> $modules */
    private function __construct(private readonly array $modules)
    {
    }

    public static function empty(): self
    {
        return new self([]);
    }

    public static function fromModules(Module ...$modules): self
    {
        return new self(array_values($modules));
    }

    public function boot(): void
    {
        foreach ($this->modules as $module) {
            $module->register();
        }
    }
}
