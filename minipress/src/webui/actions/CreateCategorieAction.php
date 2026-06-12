<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use minipress\application_core\application\useCases\CategorieService;
use minipress\application_core\application\useCases\GestionUserService;
use minipress\conf\CsrfHelper;
use Slim\Views\Twig;

class CreateCategorieAction{

    public function __invoke(Request $request, Response $response): Response{
        $userService = new GestionUserService();
        $currentUser = $userService->getCurrentUser();

        if (!$currentUser) {
            return $response->withHeader('Location', '/signin')->withStatus(302);
        }

        $data = $request->getParsedBody();

        if (!CsrfHelper::validate($data)) {
            return $response->withStatus(403);
        }

        try {
            $service = new CategorieService();
            $service->createCategorie(nom: $data['nom'] ?? '');

            return $response->withHeader('Location', '/')->withStatus(302);

        } catch (\InvalidArgumentException $e) {
            $view = Twig::fromRequest($request);
            return $view->render($response, 'form.create.categorie.twig', [
                'error'        => $e->getMessage(),
                'current_user' => $currentUser,
            ]);
        }
    }
}