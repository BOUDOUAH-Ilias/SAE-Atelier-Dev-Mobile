<?php

declare(strict_types=1);

return function (\Slim\App $app): void {

  $app->get('/', minipress\webui\actions\GetHomeAction::class)
        ->setName('home');
};
