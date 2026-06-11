<?php

namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\Article;
use minipress\application_core\application\useCases\ArticleInterface;

class ArticleService implements ArticleInterface {

    public function getArticles(): array {
        return Article::all()->toArray();
    }

    public function getArticleById(int $id): array {
        try {
            return Article::findOrFail($id)->toArray();
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            throw new EntityNotFoundException("Article", $id);
        }
    }
}