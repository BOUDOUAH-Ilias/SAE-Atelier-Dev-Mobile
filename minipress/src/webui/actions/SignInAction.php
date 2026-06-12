<?php

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;

class SignInAction {

    private $userService;

    public function __construct($userService){
        $this->userService = $userService;
    }

    public function __invoke(Request $request, Response $response)
    {
        $view = Twig::fromRequest($request);

        if ($request->getMethod() === 'GET') {
            return $view->render($response, 'signin.twig');
        }

        $data = $request->getParsedBody();

        try {
            $user = $this->userService->authenticateUser(
                $data['email'],
                $data['password']
            );

            $this->userService->startUserSession($user);

            return $response->withHeader('Location', '/')->withStatus(302);

        } catch (\Exception $e) {
            return $view->render($response, 'signin.twig', [
                'error' => $e->getMessage()
            ]);
        }
    }
}
