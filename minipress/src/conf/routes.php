<?php

declare(strict_types=1);

return function (\Slim\App $app): void {

    $app->get('/', gift\appli\webui\actions\GetHomeAction::class)
        ->setName('home');

    $app->get('/categories', gift\appli\webui\actions\GetCategoriesAction::class)
        ->setName('categories');

    $app->get('/categorie[/{id}]', gift\appli\webui\actions\GetCategorieAction::class)
        ->setName('categorie');

    $app->get('/coffretType', gift\appli\webui\actions\GetCoffretTypeAction::class)
        ->setName('coffretType');

    $app->get('/prestations', gift\appli\webui\actions\GetPrestationsListAction::class)
        ->setName('prestations');

    $app->get('/prestation/{id}', gift\appli\webui\actions\GetPrestationAction::class)
        ->setName('prestation');

    $app->get('/categorie/{id}/prestations', gift\appli\webui\actions\GetPrestationsByCategorieAction::class)
        ->setName('prestations_by_categorie');

    $app->get('/coffretType/{id}', gift\appli\webui\actions\GetCoffretByIdAction::class)
        ->setName('coffret_by_id');

    $app->post('/prestation/{id}/add', gift\appli\webui\actions\PostAddPrestationAction::class)
        ->setName('addPrestation');

    $app->post('/prestation/{id}/sub', gift\appli\webui\actions\PostSubPrestationAction::class)
        ->setName('subPrestation');
    
    $app->post('/prestation/{id}/delete', gift\appli\webui\actions\PostDeletePrestationAction::class)
        ->setName('deletePrestation');

    $app->get('/box/create', gift\appli\webui\actions\GetCreateBoxAction::class)
        ->setName('boxCreate');

    $app->get('/coffretType/{id}/box/create', gift\appli\webui\actions\GetCreateBoxFromCoffretAction::class)
        ->setName('boxCreateFromCoffret');

    $app->post('/box/create', gift\appli\webui\actions\PostCreateBoxAction::class)
        ->setName('postBoxCreate');

    $app->get('/box/access/{token}', gift\appli\webui\actions\GetBoxByTokenAction::class)
        ->setName('boxByToken');

    $app->get('/box/{id}/token', gift\appli\webui\actions\GenerateTokenAction::class)
        ->setName('generateToken');

    $app->get('/box/{id}', gift\appli\webui\actions\GetBoxById::class)
        ->setName('boxById');

    $app->get('/validate/{id}', gift\appli\webui\actions\ValidateBoxAction::class)
        ->setName('validateBox');

    $app->get('/themes', gift\appli\webui\actions\GetThemesAction::class)
        ->setName('themes');

    $app->get('/themes/{id}', gift\appli\webui\actions\GetCoffretsByThemeAction::class)
        ->setName('theme');

     $app->get('/api/categories', gift\appli\api\actions\GetCategoriesAction::class)
        ->setName('api_categories');

    $app->get('/api/boxes/{ID}', gift\appli\api\actions\GetBoxesAction::class)
        ->setName('api_boxes');

    $app->get('/api/prestations', gift\appli\api\actions\GetPrestationsAction::class)
        ->setName('api_prestations');
    
    $app->get('/api/categories/{id}/prestations', gift\appli\api\actions\GetPrestationsByCategoryAction::class)
        ->setName('api_prestationsByCategory');
    
    $app->get('/signin',  [gift\appli\webui\actions\SignInAction::class, 'showForm'])->setName('signin');
    $app->post('/signin', [gift\appli\webui\actions\SignInAction::class, 'signin'])->setName('signin.post');

    $app->get('/register', [gift\appli\webui\actions\RegisterAction::class, 'showForm'])->setName('register');
    $app->post('/register', [gift\appli\webui\actions\RegisterAction::class, 'register'])->setName('register.post');

    $app->get('/signout', gift\appli\webui\actions\SignOutAction::class)->setName('signout');

    $app->get('/profile', gift\appli\webui\actions\GetProfileAction::class)->setName('profile');
};
