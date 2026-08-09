<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Localization;

interface LocalePreferenceStore
{
    public function read(): ?string;

    public function write(string $locale): void;
}
