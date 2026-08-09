<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Architecture;

use FactoryUtility\Tests\Architecture\Support\DependencyPolicy;
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;
use RuntimeException;
use SplFileInfo;

final class DependencyFitnessTest extends TestCase
{
    private const SOURCE_ROOT = __DIR__ . '/../../src';

    /** @return iterable<string, array{string}> */
    public static function phpFiles(): iterable
    {
        $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator(self::SOURCE_ROOT));

        foreach ($iterator as $file) {
            if ($file instanceof SplFileInfo && $file->isFile() && $file->getExtension() === 'php') {
                yield $file->getPathname() => [$file->getPathname()];
            }
        }
    }

    #[DataProvider('phpFiles')]
    public function testNamespaceMatchesPsr4Path(string $file): void
    {
        $source = $this->read($file);
        $matched = preg_match('/namespace\s+([^;]+);/', $source, $matches);

        if ($matched !== 1) {
            self::fail("Missing namespace declaration in {$file}");
        }

        $relative = str_replace(self::SOURCE_ROOT . '/', '', $file);
        $directory = str_replace('/', '\\', dirname($relative));
        $expected = 'FactoryUtility\\' . ($directory === '.' ? '' : $directory);

        self::assertSame($expected, $matches[1]);
    }

    #[DataProvider('phpFiles')]
    public function testDependencyDirection(string $file): void
    {
        $source = $this->read($file);
        $relative = str_replace(self::SOURCE_ROOT . '/', '', $file);
        $imports = $this->imports($source);

        self::assertSame([], DependencyPolicy::violations($relative, $imports, $source));
    }

    /** @return list<string> */
    private function imports(string $source): array
    {
        preg_match_all('/^use\s+([^;]+);/m', $source, $matches);

        return $matches[1];
    }

    private function read(string $file): string
    {
        $source = file_get_contents($file);

        if ($source === false) {
            throw new RuntimeException("Unable to read {$file}");
        }

        return $source;
    }
}
