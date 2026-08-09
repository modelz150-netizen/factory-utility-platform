<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Dashboard;

use Throwable;

final readonly class DashboardComposer
{
    public function __construct(private WidgetRegistry $registry, private WidgetRenderer $renderer)
    {
    }

    /**
     * @param array<string, WidgetProjection> $projections
     * @return list<RenderedWidget>
     */
    public function compose(DashboardDescriptor $dashboard, array $projections, string $locale): array
    {
        $rendered = [];
        foreach ($this->registry->forDashboard($dashboard) as $widget) {
            $projection = $projections[$widget->id] ?? new WidgetProjection(ViewState::Unavailable, 'state.unavailable', []);
            try {
                $markup = $this->renderer->render($widget, $projection, $locale);
                $rendered[] = new RenderedWidget($widget->id, $widget->region, $markup, $projection->state, $projection->correlationId);
            } catch (Throwable) {
                $rendered[] = new RenderedWidget($widget->id, $widget->region, '', ViewState::Error, $projection->correlationId);
            }
        }

        return $rendered;
    }
}
