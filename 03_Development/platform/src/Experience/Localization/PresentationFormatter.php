<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Localization;

use DateTimeImmutable;

interface PresentationFormatter
{
    public function number(float $value, string $locale, int $precision = 2): string;

    public function dateTime(DateTimeImmutable $value, string $locale, string $timezone): string;

    public function measurement(float $value, string $canonicalUnit, string $locale): string;
}
