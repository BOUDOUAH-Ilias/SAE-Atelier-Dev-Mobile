<?php


namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\Article;
use Override;

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

    public function getArticleDesc(): array {
        return Article::with('auteur')->orderBy('date_creation', 'desc')->get();
    }


    public function getArticleByCategorie(int $idCategorie): array
    {
        return Article::where('id_categorie', $idCategorie)
            ->orderBy('date_creation', 'desc')
            ->get();
    }
  

    public function getArticles(): array {
        return Article::with('auteur')->get();
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