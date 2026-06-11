<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use minipress\application_core\application\useCases\CategorieService;
use minipress\application_core\application\useCases\GestionUserService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;

class ShowCreateArticleAction{

    public function __invoke(Request $request, Response $response, array $args): Response
    {
        $view = Twig::fromRequest($request);
        $userService = new GestionUserService();
        $user = $userService->getCurrentUser();

        if (!$user) {
            return $response
                ->withHeader('Location', '/signin')
                ->withStatus(302);
        }
        $service = new CategorieService();
        return $view->render($response, 'form.create.article.twig', [
            'categories' => $service->getCategories(),
            'user' => $user
        ]);
    }
}