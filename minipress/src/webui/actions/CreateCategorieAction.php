<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use minipress\application_core\application\useCases\CategorieService;

class CreateCategorieAction{

    public function __invoke(Request $request, Response $response): Response{
        $data = $request->getParsedBody();

        $service = new CategorieService();
        $service->createCategorie(
            nom: $data['nom'],
        );

        return $response->withHeader('Location', '/')->withStatus(200);
    }
}