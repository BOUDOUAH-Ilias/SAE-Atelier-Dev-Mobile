<?php
namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;
use minipress\application_core\application\useCases\GestionUserService;

class CreateUserAction
{

    public function __invoke(Request $request, Response $response): Response
    {
        $view = Twig::fromRequest($request);
        $userService = new GestionUserService();

        $currentUser = $userService->getCurrentUser();
        if (!$currentUser || $currentUser->is_admin !== 1) {
            return $response->withHeader('Location', '/')->withStatus(302);
        }

        $data = $request->getParsedBody();
        $email = $data['email'] ?? '';
        $password = $data['password'] ?? '';

        $error = null;
        $success = null;

        try {
            // Appel au service métier (découplage)
            $userService->registerUser($email, $password);
            $success = "L'utilisateur a été créé avec succès.";
        } catch (\Exception $e) {
            $error = $e->getMessage();
        }

        return $view->render($response, 'creerUser.twig', [
            'error' => $error,
            'success' => $success
        ]);
    }
}