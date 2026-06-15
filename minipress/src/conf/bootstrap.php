<?php

declare(strict_types=1);

use Slim\Factory\AppFactory;
use Slim\Views\Twig;
use Slim\Views\TwigMiddleware;
use minipress\infrastructure\Eloquent;

session_start();

Eloquent::init(__DIR__ . '/db.ini');

$app = AppFactory::create();

$basePath = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
$app->setBasePath($basePath);

$twig = Twig::create(__DIR__ . '/../webui/views/', ['cache' => false]);

$twig->getEnvironment()->addGlobal('base_path', $basePath);
$twig->getEnvironment()->addGlobal('current_user', $_SESSION['auth_user'] ?? null);
$twig->getEnvironment()->addGlobal('csrf_token', \minipress\conf\CsrfHelper::getToken());
$twig->getEnvironment()->addGlobal('css_dir', $basePath . '/public/css');

$converter = new \League\CommonMark\CommonMarkConverter(['html_input' => 'strip', 'allow_unsafe_links' => false]);
$twig->getEnvironment()->addFilter(new \Twig\TwigFilter(
    'markdown',
    fn(string $text): string => $converter->convert($text)->getContent(),
    ['is_safe' => ['html']]
));

$app->add(TwigMiddleware::create($app, $twig));

$routes = require_once __DIR__ . '/routes.php';
$routes($app);

$app->addErrorMiddleware(true, true, true);

$app->add(function ($request, $handler) {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    return $handler->handle($request);
});

$app->add(function ($request, $handler) {
    $response = $handler->handle($request);
    return $response
        ->withHeader('Access-Control-Allow-Origin', '*')
        ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
        ->withHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
});

return $app;
