<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Architecture;

use FactoryUtility\Tests\Architecture\Support\DependencyPolicy;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

final class DependencyPolicyTest extends TestCase
{
    /** @return iterable<string, array{string, list<string>, string}> */
    public static function prohibitedDependencies(): iterable
    {
        yield 'domain to infrastructure' => [
            'Modules/Electrical/Domain/Service.php',
            ['FactoryUtility\\Modules\\Electrical\\Infrastructure\\Repository'],
            '',
        ];
        yield 'domain to WordPress global' => [
            'Modules/Electrical/Domain/Service.php',
            [],
            'add_action("init", $callback);',
        ];
        yield 'application to adapter' => [
            'Modules/Electrical/Application/UseCase.php',
            ['FactoryUtility\\Adapters\\WordPress\\Gateway'],
            '',
        ];
        yield 'experience to domain' => [
            'Experience/View.php',
            ['FactoryUtility\\Modules\\Electrical\\Domain\\Reading'],
            '',
        ];
        yield 'private cross-module import' => [
            'Modules/Electrical/Application/UseCase.php',
            ['FactoryUtility\\Modules\\Water\\Domain\\Reading'],
            '',
        ];
    }

    /** @param list<string> $imports */
    #[DataProvider('prohibitedDependencies')]
    public function testItRejectsProhibitedDependencies(string $relative, array $imports, string $source): void
    {
        self::assertNotSame([], DependencyPolicy::violations($relative, $imports, $source));
    }

    public function testItAllowsPublishedCrossModuleContracts(): void
    {
        $violations = DependencyPolicy::violations(
            'Modules/Electrical/Application/UseCase.php',
            ['FactoryUtility\\Modules\\Water\\Contracts\\Reading'],
            '',
        );

        self::assertSame([], $violations);
    }
}
