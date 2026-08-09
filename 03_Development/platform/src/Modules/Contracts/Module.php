<?php

declare(strict_types=1);

namespace FactoryUtility\Modules\Contracts;

/**
 * Minimal lifecycle contract implemented only by approved Platform modules.
 */
interface Module
{
    public function register(): void;
}
