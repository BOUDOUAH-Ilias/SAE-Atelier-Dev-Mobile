<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use minipress\application_core\application\useCases\GestionArticleService;

class CreateArticleAction{

    public function __invoke(Request $request, Response $response, array $args): Response{
        $data = $request->getParsedBody();

        $service = new GestionArticleService();
        $service->createArticle(
            titre:       $data['titre'],
            resume:      $data['resume'] ?? null,
            contenu:     $data['contenu'],
            publie:      isset($data['publie']),
            imageUrl:    $data['image_url'] ?? null,
            idCategorie: (int) $data['id_categorie'],
            idAuteur:    (int) ($_SESSION['auth_user']['id'] ?? 1),
        );

        return $response->withHeader('Location', '/')->withStatus(200);
    }
}
