<?php
namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;
use minipress\application_core\application\useCases\GestionUserService;

class ShowCreateUserAction
{

    public function __invoke(Request $request, Response $response): Response
    {
        $view = Twig::fromRequest($request);
        $userService = new GestionUserService();

        $currentUser = $userService->getCurrentUser();
        if (!$currentUser || $currentUser->is_admin !== 1) {
            return $response->withHeader('Location', '/')->withStatus(302);
        }

        return $view->render($response, 'creerUser.twig');
    }
}