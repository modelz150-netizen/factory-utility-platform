<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Experience;

use PHPUnit\Framework\TestCase;

final class DesignSystemFoundationTest extends TestCase
{
    private const ROOT = __DIR__ . '/../..';

    public function testTokenLayersAndReferencesAreValid(): void
    {
        $data = json_decode((string) file_get_contents(self::ROOT . '/assets/design-system/tokens/tokens.json'), true, 512, JSON_THROW_ON_ERROR);
        self::assertIsArray($data);
        self::assertSame(['primitive', 'semantic', 'component'], array_values(array_intersect(['primitive', 'semantic', 'component'], array_keys($data))));
        $names = [];
        foreach (['primitive', 'semantic', 'component'] as $layer) {
            $tokens = $data[$layer] ?? null;
            self::assertIsArray($tokens);
            foreach ($tokens as $name => $value) {
                self::assertIsString($name);
                self::assertIsString($value);
                self::assertArrayNotHasKey($name, $names, "Duplicate token {$name}");
                $names[$name] = true;
                if ($layer === 'component') {
                    self::assertMatchesRegularExpression('/^\{(primitive|semantic)\.|^[^{]/', $value);
                }
            }
        }
    }

    public function testGeneratedTokensAreCurrent(): void
    {
        exec('php ' . escapeshellarg(self::ROOT . '/tools/design-system/generate-tokens.php') . ' --check', $output, $status);
        self::assertSame(0, $status, 'Generated tokens.css must match tokens.json.');
    }

    public function testCssContractsAndBudget(): void
    {
        $files = glob(self::ROOT . '/assets/design-system/css/*.css') ?: [];
        $css = implode("\n", array_map(static fn (string $file): string => (string) file_get_contents($file), $files));
        self::assertStringNotContainsString('#wp', $css);
        self::assertStringNotContainsString('dashboard', strtolower($css));
        $compressed = gzencode($css);
        self::assertNotFalse($compressed);
        self::assertLessThanOrEqual(50 * 1024, strlen($compressed), 'Compressed CSS exceeds the 50 KB implementation target.');
        self::assertStringContainsString('prefers-reduced-motion: reduce', $css);
        self::assertStringContainsString('forced-colors: active', $css);
        self::assertStringContainsString(':focus-visible', $css);
        self::assertStringContainsString('2.75rem', $css);
    }

    public function testFixtureIsNonProductionAndAccessibleByContract(): void
    {
        $html = (string) file_get_contents(self::ROOT . '/tests/Fixtures/DesignSystem/index.html');
        self::assertStringContainsString('Skip to main content', $html);
        self::assertStringContainsString('<main', $html);
        self::assertStringContainsString('<caption>', $html);
        self::assertStringContainsString('<dialog', $html);
        self::assertStringContainsString('Simulated', $html);
        foreach (['SCADA', 'API endpoint', 'production data', 'authentication'] as $prohibited) {
            self::assertStringNotContainsString($prohibited, $html);
        }
    }

    public function testIconManifestOwnsFirstPartyAssets(): void
    {
        $manifest = (string) file_get_contents(self::ROOT . '/assets/design-system/icons/manifest.json');
        foreach (['information.svg', 'check.svg', 'warning.svg'] as $file) {
            self::assertStringContainsString('"source": "first-party"', $manifest);
            self::assertStringContainsString('"file": "' . $file . '"', $manifest);
            self::assertFileExists(self::ROOT . '/assets/design-system/icons/' . $file);
        }
    }
}
