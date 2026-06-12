<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;
use minipress\application_core\application\useCases\GestionArticleService;

class PublierArticleAction
{

    public function __invoke(Request $request, Response $response, array $args): Response
    {
        if (empty($_SESSION['auth_user']['id'])) {
            return $response->withHeader('Location', '/signin')->withStatus(302);
        }

        $articleId = (int) $args['id'];
        $userId = (int) $_SESSION['auth_user']['id'];

        $service = new GestionArticleService();

        $article = $service->getArticleById($articleId);
        if (!$article || $article['id_auteur'] !== $userId) {
            return $response->withStatus(403);
        }

        $service->updatePublie($articleId);

        return $response->withHeader('Location', '/maliste')->withStatus(302);
    }
}
