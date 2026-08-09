<?php

declare(strict_types=1);

namespace FactoryUtility\Adapters\WordPress;

enum RuntimeEnvironment: string
{
    case Development = 'development';
    case Staging = 'staging';
    case Production = 'production';

    public static function fromWordPress(string $value): self
    {
        return match ($value) {
            'development', 'local' => self::Development,
            'staging' => self::Staging,
            default => self::Production,
        };
    }

    public function permitsFixtures(): bool
    {
        return $this !== self::Production;
    }
}
