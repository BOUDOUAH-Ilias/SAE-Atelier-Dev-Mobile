<?php


namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\Article;

class GestionArticleService implements GestionArticleServiceInterface{

    public function createArticle(string $titre, ?string $resume, string $contenu, bool $publie, ?string $imageUrl, int $idCategorie, int $idAuteur): void{
        $article = new Article();
        $article->titre        = $titre;
        $article->resume       = $resume;
        $article->contenu      = $contenu;
        $article->publie       = $publie;
        $article->image_url    = $imageUrl;
        $article->id_categorie = $idCategorie;
        $article->id_auteur    = $idAuteur;
        $article->save();
    }

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
?>