<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Architecture\Support;

final class DependencyPolicy
{
    /**
     * @param list<string> $imports
     * @return list<string>
     */
    public static function violations(string $relative, array $imports, string $source): array
    {
        $violations = [];

        if (str_contains($relative, '/Domain/')) {
            $violations = self::forbiddenImports(
                $imports,
                ['Application', 'Infrastructure', 'Experience', 'Adapters', 'Platform\\Bootstrap'],
            );
            $violations = [...$violations, ...self::wordpressViolations($source)];
        }

        if (str_contains($relative, '/Application/')) {
            $violations = [
                ...$violations,
                ...self::forbiddenImports(
                    $imports,
                    ['Infrastructure', 'Experience', 'Adapters', 'Platform\\Bootstrap'],
                ),
                ...self::wordpressViolations($source),
            ];
        }

        if (str_starts_with($relative, 'Experience/')) {
            $violations = [
                ...$violations,
                ...self::forbiddenImports($imports, ['\\Domain\\', '\\Infrastructure\\']),
            ];
        }

        return [...$violations, ...self::crossModuleViolations($relative, $imports)];
    }

    /**
     * @param list<string> $imports
     * @param list<string> $forbidden
     * @return list<string>
     */
    private static function forbiddenImports(array $imports, array $forbidden): array
    {
        $violations = [];

        foreach ($imports as $import) {
            foreach ($forbidden as $fragment) {
                if (str_contains($import, $fragment)) {
                    $violations[] = "Forbidden dependency: {$import}";
                }
            }
        }

        return $violations;
    }

    /** @return list<string> */
    private static function wordpressViolations(string $source): array
    {
        if (preg_match('/\b(?:add_action|add_filter|do_action|apply_filters|wp_|get_option|update_option)\s*\(/', $source) === 1) {
            return ['WordPress global used inside core package'];
        }

        return [];
    }

    /**
     * @param list<string> $imports
     * @return list<string>
     */
    private static function crossModuleViolations(string $relative, array $imports): array
    {
        if (preg_match('#^Modules/([^/]+)/#', $relative, $owner) !== 1) {
            return [];
        }

        $violations = [];

        foreach ($imports as $import) {
            if (preg_match('/^FactoryUtility\\\\Modules\\\\([^\\\\]+)\\\\/', $import, $dependency) !== 1) {
                continue;
            }

            if ($dependency[1] !== $owner[1] && ! str_contains($import, '\\Contracts\\')) {
                $violations[] = "Module {$owner[1]} imports private type {$import}";
            }
        }

        return $violations;
    }
}
