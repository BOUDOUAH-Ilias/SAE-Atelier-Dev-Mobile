<?php

declare(strict_types=1);

namespace minipress\webui\actions;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Views\Twig;
use minipress\application_core\application\useCases\GestionArticleService;
use minipress\application_core\application\useCases\GestionUserService;
use minipress\application_core\application\useCases\CategorieService;

class ShowListArticleByCategorieAction {

    public function __invoke(Request $request, Response $response, array $args): Response {
        $view        = Twig::fromRequest($request);
        $currentUser = (new GestionUserService())->getCurrentUser();
        $categoryId  = (int) $args['id'];
        $service     = new GestionArticleService();

        if ($currentUser && $currentUser->is_admin === 1) {
            $articles = $service->getAllArticlesByCategorie($categoryId);
        } elseif ($currentUser) {
            $articles = $service->getArticlesByCategorieForUser($categoryId, (int) $currentUser->id);
        } else {
            $articles = $service->getArticleByCategorie($categoryId);
        }

        return $view->render($response, 'list.article.twig', [
            'articles'     => $articles,
            'current_user' => $currentUser,
            'categories'   => (new CategorieService())->getCategories(),
            'active_cat'   => $categoryId,
        ]);
    }
}
