<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;
use minipress\application_core\application\useCases\GestionArticleService;
use minipress\application_core\application\useCases\GestionUserService;
use minipress\application_core\application\useCases\CategorieService;
use minipress\conf\CsrfHelper;

class CreateArticleAction {

    public function __invoke(Request $request, Response $response): Response
    {
        $userService = new GestionUserService();
        $user = $userService->getCurrentUser();

        if (!$user) {
            return $response->withHeader('Location', '/signin')->withStatus(302);
        }

        $data = $request->getParsedBody();

        if (!CsrfHelper::validate($data)) {
            return $response->withStatus(403);
        }

        try {
            $service = new GestionArticleService();
            $service->createArticle(
                titre: $data['titre'] ?? '',
                resume: $data['resume'] ?? null,
                contenu: $data['contenu'] ?? '',
                publie: isset($data['publie']),
                imageUrl: $data['image_url'] ?? null,
                idCategorie: (int) ($data['id_categorie'] ?? 0),
                idAuteur: (int) $user->id
            );

            return $response->withHeader('Location', '/articles')->withStatus(302);

        } catch (\InvalidArgumentException $e) {
            $view = Twig::fromRequest($request);
            $categories = (new CategorieService())->getCategories();
            return $view->render($response, 'form.create.article.twig', [
                'error' => $e->getMessage(),
                'categories' => $categories,
                'user' => $user,
            ]);
        }
    }
}
