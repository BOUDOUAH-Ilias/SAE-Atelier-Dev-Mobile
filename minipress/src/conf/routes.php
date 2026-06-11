<?php

declare(strict_types=1);

return function (\Slim\App $app): void {

  $app->get('/', minipress\webui\actions\GetHomeAction::class)
        ->setName('home');

  $app->get('/api/categories', minipress\api\actions\GetCategoriesAction::class)
        ->setName('api_categories');

  
    $app->get('/article/create', minipress\webui\actions\ShowCreateArticleAction::class)
        ->setName('article.create');

    $app->post('/article/create', minipress\webui\actions\CreateArticleAction::class)
        ->setName('article.create.post');

    $app->get('/articles', minipress\webui\actions\ShowListArticleAction::class)
        ->setName('article.list');

    $app->get('/articles/categorie/{id}', minipress\webui\actions\ShowListArticleByCategorieAction::class)
        ->setName('article.list.categorie');
};
