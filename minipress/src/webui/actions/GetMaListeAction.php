<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;
use minipress\application_core\application\useCases\GestionArticleService;
use minipress\application_core\application\useCases\GestionUserService;

class GetMaListeAction
{

    public function __invoke(Request $request, Response $response): Response
    {
        $view = Twig::fromRequest($request);
        $currentUser = (new GestionUserService())->getCurrentUser();
        $service = new GestionArticleService();
        return $view->render($response, 'maliste.twig', [
            'articles'     => $service->getArticlesDeAuteurId($_SESSION['auth_user']['id']),
            'current_user' => $currentUser,
        ]);
    }
}
