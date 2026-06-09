<?php
use Slim\Factory\AppFactory;
use Slim\Views\Twig;
use Slim\Views\TwigMiddleware;
use gift\appli\infrastructure\Eloquent;

session_start();

// src/conf/db.ini
Eloquent::init(__DIR__ . '/db.ini');

$app = AppFactory::create();

$basePath = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
$app->setBasePath($basePath);

// src/conf/../../src/views/templates = src/views/templates
$twig = Twig::create(__DIR__ . '/../webui/views/', ['cache' => false]);

$twig->getEnvironment()->addGlobal('nav_menu', [
    ['url' => $basePath . '/', 'label' => 'Accueil'],
    ['url' => $basePath . '/prestations', 'label' => 'Toutes les prestations'],
    ['url' => $basePath . '/categories', 'label' => 'Catégories'],
    ['url' => $basePath . '/coffretType', 'label' => 'Liste des coffrets types'],
    ['url' => $basePath . '/themes', 'label' => 'Liste des themes'],
]);
$twig->getEnvironment()->addGlobal('current_user', $_SESSION['auth_user'] ?? null);
$twig->getEnvironment()->addGlobal('css_dir', $basePath . '/public/css');
$twig->getEnvironment()->addGlobal('img_dir', $basePath . '/public/img');
$current_box_id = $_SESSION['current_box_id'] ?? null;
$twig->getEnvironment()->addGlobal('current_box_id', $current_box_id);

$current_box_statut = null;
if ($current_box_id) {
    try {
        $currentBox = \gift\appli\application_core\domain\entities\Box::find($current_box_id);
        $current_box_statut = $currentBox ? $currentBox->statut : null;
    } catch (\Exception $e) {}
}
$twig->getEnvironment()->addGlobal('current_box_statut', $current_box_statut);
$app->add(TwigMiddleware::create($app, $twig));

// src/conf/routes.php
$routes = require_once __DIR__ . '/routes.php';
$routes($app);

$app->addErrorMiddleware(true, true, true);

$app->add(function ($request, $handler) {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    return $handler->handle($request);
});

return $app;