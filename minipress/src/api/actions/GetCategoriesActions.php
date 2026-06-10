<?php
declare(strict_types=1);

namespace minipress\api\actions;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\application_core\application\useCases\CategorieService;

class GetCategoriesAction {

public function __invoke(Request $rs, Response $response, array $args){
    $service = new CategoriesService();
    $categories = $service->getCategories();

    $data = [
            'type'       => 'collection',
            'count'      => count($categories),
            'categories' => array_map(function (array $cat) {
                return [
                    'categorie' => [
                        'id'          => $cat['id'],
                        'nom'     => $cat['nom'],
                    ],
                    'links' => [
                        'self' => ['href' => '/categories/' . $cat['id'] . '/'],
                    ],
                ];
            }, $categories),
        ];

    $rs->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));

    return $rs->withHeader('Content-Type', 'application/json');
}
}