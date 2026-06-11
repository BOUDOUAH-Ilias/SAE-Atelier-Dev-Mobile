<?php

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class SignOutAction {

    private $userService;

    public function __construct($userService){
        $this->userService = $userService;
    }

    public function __invoke(Request $request, Response $response)
    {
        $this->userService->logoutUser();

        return $response
            ->withHeader('Location', '/')
            ->withStatus(302);
    }
}