<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use minipress\application_core\application\useCases\CategorieService;
use minipress\application_core\application\useCases\GestionUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;

class ShowCreateCategorieAction{

    public function __invoke(Request $request, Response $response, array $args): Response{
        $userService = new GestionUserService();
        $currentUser = $userService->getCurrentUser();

        if (!$currentUser) {
            return $response->withHeader('Location', '/signin')->withStatus(302);
        }

        $view = Twig::fromRequest($request);
        return $view->render($response, 'form.create.categorie.twig', [
            'current_user' => $currentUser,
        ]);
    }
}