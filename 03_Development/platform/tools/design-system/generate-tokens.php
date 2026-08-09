<?php

declare(strict_types=1);

$root = dirname(__DIR__, 2);
$source = $root . '/assets/design-system/tokens/tokens.json';
$target = $root . '/assets/design-system/css/tokens.css';
$data = json_decode((string) file_get_contents($source), true, 512, JSON_THROW_ON_ERROR);
$lines = ["/* Generated from tokens/tokens.json. Do not edit directly. */", '@layer tokens {', '  :root {'];

foreach (['primitive', 'semantic', 'component'] as $layer) {
    foreach ($data[$layer] as $name => $value) {
        $value = preg_replace_callback('/\{(primitive|semantic)\.([^}]+)\}/', static fn (array $m): string => "var(--fup-{$m[2]})", (string) $value);
        $lines[] = "    --fup-{$name}: {$value};";
    }
}

$lines[] = '    --fup-font-sans: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;';
$lines[] = '    --fup-font-mono: ui-monospace, "SFMono-Regular", Consolas, monospace;';
$lines[] = '    --fup-content-measure: 72ch;';
$lines[] = '  }';
$lines[] = '}';
$output = implode("\n", $lines) . "\n";

if (($argv[1] ?? '') === '--check') {
    exit(is_file($target) && file_get_contents($target) === $output ? 0 : 1);
}

file_put_contents($target, $output);
