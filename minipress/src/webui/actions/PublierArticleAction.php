<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use minipress\application_core\application\useCases\GestionArticleService;
use minipress\application_core\application\useCases\GestionUserService;
use minipress\application_core\application\exceptions\EntityNotFoundException;
use minipress\conf\CsrfHelper;

class PublierArticleAction
{
    public function __invoke(Request $request, Response $response, array $args): Response
    {
        $userService = new GestionUserService();
        $currentUser = $userService->getCurrentUser();

        if (!$currentUser) {
            return $response->withHeader('Location', '/signin')->withStatus(302);
        }

        $data = $request->getParsedBody();
        if (!CsrfHelper::validate($data)) {
            return $response->withStatus(403);
        }

        $articleId = (int) $args['id'];
        $service = new GestionArticleService();

        try {
            $article = $service->getArticleById($articleId);
        } catch (EntityNotFoundException $e) {
            return $response->withStatus(404);
        }

        $isAdmin  = $currentUser->is_admin === 1;
        $isAuthor = (int) $article['id_auteur'] === (int) $currentUser->id;

        if (!$isAdmin && !$isAuthor) {
            return $response->withStatus(403);
        }

        // L'admin peut uniquement dépublier, pas republier
        if ($isAdmin && !$isAuthor && !$article['publie']) {
            return $response->withStatus(403);
        }

        $service->updatePublie($articleId);

        $referer = $request->getHeaderLine('Referer');
        $location = str_contains($referer, 'maliste') ? '/maliste' : '/articles';

        return $response->withHeader('Location', $location)->withStatus(302);
    }
}
