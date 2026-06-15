<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;
use minipress\application_core\application\useCases\GestionArticleService;
use minipress\application_core\application\exceptions\EntityNotFoundException;

class ShowArticleDetailAction
{
    public function __invoke(Request $request, Response $response, array $args): Response
    {
        $view = Twig::fromRequest($request);
        $id = (int) $args['id'];

        try {
            $article = (new GestionArticleService())->getArticleById($id);
        } catch (EntityNotFoundException) {
            $response->getBody()->write('Article introuvable');
            return $response->withStatus(404);
        }

        return $view->render($response, 'detail.article.twig', ['article' => $article]);
    }
}
