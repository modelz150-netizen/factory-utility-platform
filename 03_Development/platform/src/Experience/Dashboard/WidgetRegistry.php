<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Dashboard;

use LogicException;

final class WidgetRegistry
{
    /** @var array<string, WidgetDescriptor> */
    private array $widgets = [];
    private bool $closed = false;

    public function register(WidgetDescriptor $widget): void
    {
        if ($this->closed) {
            throw new LogicException('Widget registration is closed.');
        }
        if (isset($this->widgets[$widget->id])) {
            throw new LogicException("Duplicate widget ID: {$widget->id}");
        }
        $this->widgets[$widget->id] = $widget;
    }

    public function close(): void
    {
        $this->closed = true;
    }

    /** @return list<WidgetDescriptor> */
    public function forDashboard(DashboardDescriptor $dashboard): array
    {
        if (!$this->closed) {
            throw new LogicException('Widget registration must close before composition.');
        }
        $widgets = array_filter($this->widgets, static fn (WidgetDescriptor $widget): bool => in_array($widget->region, $dashboard->regions, true));
        usort($widgets, static fn (WidgetDescriptor $a, WidgetDescriptor $b): int => [$a->order, $a->id] <=> [$b->order, $b->id]);

        return $widgets;
    }
}
