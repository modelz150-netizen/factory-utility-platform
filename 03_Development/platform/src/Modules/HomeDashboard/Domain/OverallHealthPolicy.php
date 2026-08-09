<?php

declare(strict_types=1);

namespace FactoryUtility\Modules\HomeDashboard\Domain;

final class OverallHealthPolicy
{
    /** @var list<string> */
    public const UTILITY_ORDER = ['electrical', 'cda', 'di_ro', 'pcw', 'chiller_cooling_tower', 'ahu_hvac', 'wwt', 'energy'];

    /** @param list<UtilityHealthInput> $inputs */
    public function aggregate(array $inputs): OverallHealthProjection
    {
        $indexed = [];
        foreach ($inputs as $input) {
            $indexed[$input->utilityKey] = $input;
        }

        $affected = [];
        $missing = false;
        $unavailable = 0;
        $hasCritical = false;
        $hasWarning = false;
        $hasUnknown = false;
        $hasStale = false;

        foreach (self::UTILITY_ORDER as $utilityKey) {
            $input = $indexed[$utilityKey] ?? null;
            if ($input === null) {
                $missing = true;
                $affected[] = $utilityKey;
                continue;
            }

            $hasStale = $hasStale || ! $input->fresh || $input->state === OperationalState::Stale;
            if (! $input->trustworthy || $input->state !== OperationalState::Normal || ! $input->fresh) {
                $affected[] = $utilityKey;
            }
            if (! $input->trustworthy) {
                $hasUnknown = true;
                continue;
            }

            $hasCritical = $hasCritical || $input->state === OperationalState::Critical;
            $hasWarning = $hasWarning || $input->state === OperationalState::Warning;
            $hasUnknown = $hasUnknown || $input->state === OperationalState::Unknown;
            $unavailable += $input->state === OperationalState::Unavailable ? 1 : 0;
        }

        $state = match (true) {
            $hasCritical => OperationalState::Critical,
            $hasWarning => OperationalState::Warning,
            ! $missing && $unavailable === count(self::UTILITY_ORDER) => OperationalState::Unavailable,
            $missing || $unavailable > 0 || $hasUnknown => OperationalState::Unknown,
            $hasStale => OperationalState::Stale,
            default => OperationalState::Normal,
        };

        return new OverallHealthProjection(
            $state,
            array_values(array_unique($affected)),
            $missing || $unavailable > 0 || $hasUnknown,
            $hasStale,
        );
    }
}
