<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Dashboard;

interface WidgetRenderer
{
    public function render(WidgetDescriptor $descriptor, WidgetProjection $projection, string $locale): string;
}
