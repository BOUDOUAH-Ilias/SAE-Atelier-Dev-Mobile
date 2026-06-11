<?php

namespace minipress\webui\actions;

use Psr\Container\ContainerInterface;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class SignUpAction{
    private $userService;

    public function __construct(ContainerInterface $container){
        $this->userService = $container->get('GestionUserService');
    }

    public function __invoke(Request $request, Response $response){
        $data = $request->getParsedBody();

        try {

            $user = $this->userService->registerUser(
                $data['email'],
                $data['password']
            );

            $this->userService->startUserSession($user);

            return $response
                ->withHeader('Location', '/')
                ->withStatus(302);

        } catch (\Exception $e) {

            $response->getBody()->write($e->getMessage());
            return $response->withStatus(400);
        }
    }
}
