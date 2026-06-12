<?php

declare(strict_types=1);

return function (\Slim\App $app): void {

    $app->get('/', minipress\webui\actions\GetHomeAction::class)
        ->setName('home');

    $app->get('/api/categories', minipress\api\actions\GetCategoriesAction::class)
        ->setName('api_categories');

    $app->get('/api/categories/{id}/articles', minipress\api\actions\GetArticlesByCategorieAction::class)
        ->setName('api_articleByCategorie');

    $app->get('/api/articles', minipress\api\actions\GetArticlesAction::class)
        ->setName('api_articles');

    $app->get('/api/articles/{id}', minipress\api\actions\GetArticleByIdAction::class)
        ->setName('api_articleById');


    $app->get('/article/create', minipress\webui\actions\ShowCreateArticleAction::class)
        ->setName('article.create');

    $app->post('/article/create', minipress\webui\actions\CreateArticleAction::class)
        ->setName('article.create.post');

    $app->get('/articles', minipress\webui\actions\ShowListArticleAction::class)
        ->setName('article.list');

    $app->get('/articles/categorie/{id}', minipress\webui\actions\ShowListArticleByCategorieAction::class)
        ->setName('article.list.categorie');  
      $app->get('/categorie/create', minipress\webui\actions\ShowCreateCategorieAction::class)
        ->setName('categorie.create');
      
         $app->post('/categorie/create', minipress\webui\actions\CreateCategorieAction::class)
        ->setName('categorie.create.post');

    $userService = new \minipress\application_core\application\useCases\GestionUserService();

    $app->get('/categorie/create', minipress\webui\actions\ShowCreateCategorieAction::class)
        ->setName('categorie.create');

    $app->post('/categorie/create', minipress\webui\actions\CreateCategorieAction::class)
        ->setName('categorie.create.post');

    $app->get('/api/auteurs/{id}/articles', minipress\api\actions\GetArticleByAuthorAction::class)
        ->setName('api_articles_par_autheur');

    $app->get('/admin/user/create', minipress\webui\actions\ShowCreateUserAction::class)
        ->setName('user.create');

    $app->post('/admin/user/create', minipress\webui\actions\CreateUserAction::class)
        ->setName('user.create.post');

    $app->map(['GET', 'POST'], '/signin',
        new \minipress\webui\actions\SignInAction($userService)
    )->setName('signin');

    $app->get('/signout',
        new \minipress\webui\actions\SignOutAction($userService)
    )->setName('signout');
};
