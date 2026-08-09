<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Localization;

use InvalidArgumentException;

final class TranslationCatalogue
{
    /** @param array<string, array<string, string>> $resources */
    public function __construct(private readonly array $resources)
    {
        if (!isset($resources[SupportedLocale::FALLBACK])) {
            throw new InvalidArgumentException('The English fallback catalogue is required.');
        }
    }

    /** @param array<string, scalar> $parameters */
    public function translate(string $key, string $locale, array $parameters = []): string
    {
        SupportedLocale::require($locale);
        $template = $this->resources[$locale][$key]
            ?? $this->resources[SupportedLocale::FALLBACK][$key]
            ?? "[missing:{$key}]";

        foreach ($parameters as $name => $value) {
            $template = str_replace('{' . $name . '}', htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'), $template);
        }

        return $template;
    }

    /** @param array<string, scalar> $parameters */
    public function plural(string $key, int $count, string $locale, array $parameters = []): string
    {
        $category = $count === 1 ? 'one' : 'other';

        return $this->translate("{$key}.{$category}", $locale, ['count' => $count] + $parameters);
    }
}
