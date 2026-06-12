<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use minipress\application_core\application\useCases\GestionArticleService;
use minipress\application_core\application\useCases\GestionUserService;

class CreateArticleAction {

    public function __invoke(Request $request, Response $response, array $args): Response
    {
        // 🔐 contrôle accès
        $userService = new GestionUserService();
        $user = $userService->getCurrentUser();

        if (!$user) {
            return $response
                ->withHeader('Location', '/signin')
                ->withStatus(302);
        }

        $data = $request->getParsedBody();

        $service = new GestionArticleService();
        $service->createArticle(
            titre: $data['titre'],
            resume: $data['resume'] ?? null,
            contenu: $data['contenu'],
            publie: isset($data['publie']),
            imageUrl: $data['image_url'] ?? null,
            idCategorie: (int) $data['id_categorie'],
            idAuteur: (int) $user->id // 🔥 IMPORTANT
        );

        return $response
            ->withHeader('Location', '/articles')
            ->withStatus(302);
    }
}