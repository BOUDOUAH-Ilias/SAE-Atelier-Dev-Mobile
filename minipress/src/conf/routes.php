<?php

declare(strict_types=1);

return function (\Slim\App $app): void {

  $app->get('/', minipress\webui\actions\GetHomeAction::class)
        ->setName('home');

  $app->get('/api/categories', minipress\api\actions\GetCategoriesAction::class)
        ->setName('api_categories');

  $app->get('/api/articles', minipress\api\actions\GetArticlesAction::class)
        ->setName('api_articles');

  $app->get('/api/article/{id}/', minipress\api\actions\GetArticleByIdAction::class)
        ->setName('api_articleById');

  $app->get('/article/create', minipress\webui\actions\ShowCreateArticleAction::class)
        ->setName('article.create');

    $app->post('/article/create', minipress\webui\actions\CreateArticleAction::class)
        ->setName('article.create.post');
};
