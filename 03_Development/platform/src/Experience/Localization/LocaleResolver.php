<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Localization;

final class LocaleResolver
{
    public function __construct(private readonly LocalePreferenceStore $preferences)
    {
    }

    /** @param list<string> $browserLocales */
    public function resolve(?string $sessionLocale, array $browserLocales): string
    {
        foreach ([$sessionLocale, $this->preferences->read(), ...$browserLocales] as $candidate) {
            if (is_string($candidate) && in_array($candidate, SupportedLocale::all(), true)) {
                return $candidate;
            }
        }

        return SupportedLocale::FALLBACK;
    }
}
