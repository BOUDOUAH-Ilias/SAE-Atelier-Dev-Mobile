<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use minipress\application_core\application\useCases\CategorieService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;

class ShowCreateArticleAction{

    public function __invoke(Request $request, Response $response, array $args): Response{
        $view = Twig::fromRequest($request);
        $service = new CategorieService();
        return $view->render($response, 'form.create.article.twig', [
            'categories' => $service->getCategories()
        ]);
    }
}