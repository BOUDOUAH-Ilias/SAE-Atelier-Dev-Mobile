<?php
declare(strict_types=1);

namespace minipress\api\actions;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
use minipress\application_core\application\useCases\ArticleService;

class GetArticleByIdAction {

public function __invoke(Request $rq, Response $rs, array $args){
    $id = intval($args['id']);
    $service = new ArticleService();
    $art = $service->getArticleById($id);

    $data = [
            'type'       => 'collection',
            'articles' => 
                 [
                    'article' => [
                        'id'          => $id,
                        'titre'          => $art['titre'],
                        'resume'          => $art['resume'],
                        'contenu'          => $art['contenu'],
                        'date_creation'     => $art['date_creation'],
                        'publie'          => $art['publie'],
                        'image_url'          => $art['image_url'],
                        'categorie'          => $art['id_categorie'],
                        'auteur'     => $art['id_auteur'],
                    ],


                ]
        ];

    $rs->getBody()->write(json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));

    return $rs->withHeader('Content-Type', 'application/json');
}
}