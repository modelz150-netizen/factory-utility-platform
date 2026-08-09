<?php

declare(strict_types=1);

namespace FactoryUtility\Experience\Dashboard;

enum ViewState: string
{
    case Loading = 'loading';
    case Empty = 'empty';
    case Partial = 'partial';
    case Stale = 'stale';
    case Unavailable = 'unavailable';
    case Simulated = 'simulated';
    case Error = 'error';
}
