<?php
declare(strict_types=1);

namespace minipress\api\actions;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\application_core\application\useCases\GestionArticleService;

class GetArticlesAction
{

    public function __invoke(Request $rq, Response $rs, array $args)
    {
        $service = new GestionArticleService();

        $sort = $rq->getQueryParams()['sort'] ?? null;

        $allowed = ['date-asc', 'date-desc', 'auteur'];
        if ($sort !== null && !in_array($sort, $allowed, true)) {
            $rs->getBody()->write(json_encode([
                'error' => 'Valeur de tri invalide. Valeurs acceptées : date-asc, date-desc, auteur'
            ]));
            return $rs->withHeader('Content-Type', 'application/json')->withStatus(400);
        }

        $articles = $service->getArticlesSorted($sort);

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
                        'self' => ['href' => 'api/articles/' . $art['id']],
                    ],
                ];
            }, $articles),
        ];

        $rs->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));

        return $rs->withHeader('Content-Type', 'application/json');
    }
}