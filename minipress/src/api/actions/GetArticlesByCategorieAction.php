<?php
declare(strict_types=1);

namespace minipress\api\actions;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\application_core\application\useCases\GestionArticleService;

class GetArticlesByCategorieAction
{

    public function __invoke(Request $rq, Response $rs, array $args)
    {
        $id = intval($args['id']);
        $service = new GestionArticleService();
        $articles = $service->getArticleByCategorie($id);

        $data = [
            'type' => 'collection',
            'count' => count($articles),
            'articles' => array_map(function (array $art) {
                return [
                    'article' => [
                        'titre' => $art['titre'],
                        'date_creation' => $art['date_creation'],
                        'auteur' => $art['id_auteur'],
                    ],

                    'links' => [
                        'self' => ['href' => '/articles/' . $art['id'] . '/'],
                    ],
                ];
            }, $articles),
        ];

        $rs->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));

        return $rs->withHeader('Content-Type', 'application/json');
    }
}