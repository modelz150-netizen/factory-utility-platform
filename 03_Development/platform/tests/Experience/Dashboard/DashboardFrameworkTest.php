<?php

declare(strict_types=1);

namespace FactoryUtility\Tests\Experience\Dashboard;

use FactoryUtility\Experience\Dashboard\DashboardComposer;
use FactoryUtility\Experience\Dashboard\DashboardDescriptor;
use FactoryUtility\Experience\Dashboard\ViewState;
use FactoryUtility\Experience\Dashboard\WidgetDescriptor;
use FactoryUtility\Experience\Dashboard\WidgetProjection;
use FactoryUtility\Experience\Dashboard\WidgetRegistry;
use FactoryUtility\Experience\Dashboard\WidgetRenderer;
use FactoryUtility\Experience\Localization\LocalePreferenceStore;
use FactoryUtility\Experience\Localization\LocaleResolver;
use FactoryUtility\Experience\Localization\SupportedLocale;
use FactoryUtility\Experience\Localization\TranslationCatalogue;
use FactoryUtility\Experience\Shell\NavigationDestination;
use FactoryUtility\Experience\Shell\RouteResolver;
use LogicException;
use PHPUnit\Framework\TestCase;
use RuntimeException;

final class DashboardFrameworkTest extends TestCase
{
    public function testSupportedLocaleOrderAndFallbackAreStable(): void
    {
        self::assertSame(['ko-KR', 'vi-VN', 'en-US'], SupportedLocale::all());
        self::assertSame('en-US', SupportedLocale::FALLBACK);
    }

    public function testTranslationFallsBackAndReportsMissingKeys(): void
    {
        $catalogue = new TranslationCatalogue([
            'en-US' => ['hello' => 'Hello {name}', 'items.one' => '{count} item', 'items.other' => '{count} items'],
            'ko-KR' => ['hello' => '안녕하세요 {name}'],
            'vi-VN' => [],
        ]);

        self::assertSame('안녕하세요 Codex', $catalogue->translate('hello', 'ko-KR', ['name' => 'Codex']));
        self::assertSame('Hello Codex', $catalogue->translate('hello', 'vi-VN', ['name' => 'Codex']));
        self::assertSame('2 items', $catalogue->plural('items', 2, 'en-US'));
        self::assertSame('[missing:unknown]', $catalogue->translate('unknown', 'en-US'));
        self::assertSame('Hello &lt;unsafe&gt;', $catalogue->translate('hello', 'en-US', ['name' => '<unsafe>']));
    }

    public function testLocaleResolutionUsesReplaceablePreferenceAndFallback(): void
    {
        $store = new class implements LocalePreferenceStore {
            public ?string $value = 'vi-VN';
            public function read(): ?string { return $this->value; }
            public function write(string $locale): void { $this->value = $locale; }
        };
        $resolver = new LocaleResolver($store);

        self::assertSame('ko-KR', $resolver->resolve('ko-KR', ['en-US']));
        self::assertSame('vi-VN', $resolver->resolve(null, ['ko-KR']));
        $store->value = 'unsupported';
        self::assertSame('ko-KR', $resolver->resolve(null, ['ko-KR']));
        self::assertSame('en-US', $resolver->resolve(null, ['unsupported']));
    }

    public function testRegistryRejectsDuplicatesAndMutationAfterClosure(): void
    {
        $registry = new WidgetRegistry();
        $widget = $this->widget('demo.status', 20);
        $registry->register($widget);
        $this->expectException(LogicException::class);
        $registry->register($widget);
    }

    public function testCompositionIsDeterministicAndContainsRendererFailure(): void
    {
        $registry = new WidgetRegistry();
        $registry->register($this->widget('demo.second', 20));
        $registry->register($this->widget('demo.first', 10));
        $registry->close();
        $renderer = new class implements WidgetRenderer {
            public function render(WidgetDescriptor $descriptor, WidgetProjection $projection, string $locale): string
            {
                if ($descriptor->id === 'demo.second') {
                    throw new RuntimeException('Simulated renderer failure.');
                }
                return $locale . ':' . $projection->labelKey;
            }
        };
        $composer = new DashboardComposer($registry, $renderer);
        $result = $composer->compose(
            new DashboardDescriptor('demo', '1.0.0', 'QA', 'page.title', ['primary']),
            [
                'demo.first' => new WidgetProjection(ViewState::Simulated, 'state.simulated', [], simulated: true),
                'demo.second' => new WidgetProjection(ViewState::Stale, 'state.stale', [], correlationId: 'demo-0001'),
            ],
            'ko-KR',
        );

        self::assertSame(['demo.first', 'demo.second'], array_column($result, 'id'));
        self::assertSame('ko-KR:state.simulated', $result[0]->markup);
        self::assertSame(ViewState::Error, $result[1]->state);
        self::assertSame('demo-0001', $result[1]->correlationId);
    }

    public function testRoutingReturnsOnlyVisibleDestination(): void
    {
        $resolver = new RouteResolver([
            new NavigationDestination('home', '/', 'nav.home', 'Experience', true),
            new NavigationDestination('future-ai', '/ai', 'nav.ai', 'AI Boundary', false, 'future'),
        ]);

        self::assertSame('home', $resolver->resolve('/')?->id);
        self::assertNull($resolver->resolve('/ai'));
        self::assertNull($resolver->resolve('/unknown'));
    }

    private function widget(string $id, int $order): WidgetDescriptor
    {
        return new WidgetDescriptor($id, '1.0.0', 'QA', 'generic', 'primary', ViewState::cases(), $order);
    }
}
