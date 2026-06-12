<?php

declare(strict_types=1);

namespace minipress\api\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use minipress\application_core\application\useCases\GestionArticleService;
use minipress\application_core\application\exceptions\EntityNotFoundException as ApplicationEntityNotFoundException;

class GetArticleByAuthorAction
{
    public function __invoke(Request $rq, Response $rs, array $args): Response
    {
        $id = (int) $args['id'];
        $service = new GestionArticleService();

        try {
            $articles = $service->getArticlesParAutheurId($id);
        } catch (ApplicationEntityNotFoundException $e) {
            $rs->getBody()->write(json_encode(
                ['error' => 'Auteur introuvable ou aucun article associé'],
                JSON_UNESCAPED_UNICODE
            ));
            return $rs->withHeader('Content-Type', 'application/json')->withStatus(404);
        }

        $data = [
            'type' => 'collection',
            'articles' => array_map(function (\minipress\application_core\domain\entities\Article $article) use ($rq) {
                $base = $rq->getUri()->getScheme() . '://' . $rq->getUri()->getHost();

                $auteur = $article->auteur ? $article->auteur->toArray() : null;

                return [
                    'titre' => $article->titre,
                    'date_creation' => $article->date_creation,
                    'auteur' => $auteur,
                    'url' => $base . '/api/articles/' . $article->id,
                ];
            }, $articles)
        ];

        $rs->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
        return $rs->withHeader('Content-Type', 'application/json')->withStatus(200);
    }
}