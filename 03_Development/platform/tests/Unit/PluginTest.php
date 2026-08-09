<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Unit;

use FactoryUtility\Modules\Contracts\Module;
use FactoryUtility\Platform\Bootstrap\Plugin;
use PHPUnit\Framework\TestCase;

final class PluginTest extends TestCase
{
    public function testItRegistersEachConfiguredModuleOnce(): void
    {
        $module = new class implements Module {
            public int $registrations = 0;

            public function register(): void
            {
                ++$this->registrations;
            }
        };

        Plugin::fromModules($module)->boot();

        self::assertSame(1, $module->registrations);
    }

    public function testEmptyCompositionRootBootsWithoutModules(): void
    {
        self::expectNotToPerformAssertions();

        Plugin::empty()->boot();
    }
}
