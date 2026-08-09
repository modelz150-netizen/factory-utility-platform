<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Localization;

use InvalidArgumentException;

final class SupportedLocale
{
    public const KOREAN = 'ko-KR';
    public const VIETNAMESE = 'vi-VN';
    public const ENGLISH = 'en-US';
    public const FALLBACK = self::ENGLISH;

    /** @return list<string> */
    public static function all(): array
    {
        return [self::KOREAN, self::VIETNAMESE, self::ENGLISH];
    }

    public static function require(string $locale): string
    {
        if (!in_array($locale, self::all(), true)) {
            throw new InvalidArgumentException("Unsupported locale: {$locale}");
        }

        return $locale;
    }
}
