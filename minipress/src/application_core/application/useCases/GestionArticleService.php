<?php


namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\Article;
use minipress\application_core\application\exceptions\EntityNotFoundException;
use Override;

class GestionArticleService implements GestionArticleServiceInterface
{

    public function createArticle(string $titre, ?string $resume, string $contenu, bool $publie, ?string $imageUrl, int $idCategorie, int $idAuteur): void
    {
        $article = new Article();
        $article->titre = $titre;
        $article->resume = $resume;
        $article->contenu = $contenu;
        $article->publie = $publie;
        $article->image_url = $imageUrl;
        $article->id_categorie = $idCategorie;
        $article->id_auteur = $idAuteur;
        $article->save();
    }

    public function getArticleDesc(): array
    {
        return Article::orderBy('date_creation', 'desc')->where('publie', 1)->get()->toArray();
    }

    public function getArticleAsc(): array
    {
        return Article::orderBy('date_creation', 'asc')->where('publie', 1)->get()->toArray();
    }


    public function getArticleByCategorie(int $idCategorie): array
    {
        return Article::where('id_categorie', $idCategorie)
            ->orderBy('date_creation', 'desc')
            ->where('publie', 1)
            ->get()
            ->toArray();
    }

    public function getArticles(): array
    {
        return Article::where('publie', 1)->get()->toArray();
    }

    public function getArticleById(int $id): array
    {
        try {
            return Article::findOrFail($id)->toArray();
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            throw new EntityNotFoundException("Article", $id);
        }
    }


    public function getArticlesParAutheurId(int $idAuteur): array
    {
        return Article::where('id_auteur', $idAuteur)->where('publie', 1)->with('auteur')->get()->all();
    }

    public function getArticlesSorted(?string $sort): array
    {
        $query = Article::where('publie', 1);

        switch ($sort) {
            case 'date-asc':
                $query->orderBy('date_creation', 'asc');
                break;
            case 'date-desc':
                $query->orderBy('date_creation', 'desc');
                break;
            case 'auteur':
                $query->join('user', 'article.id_auteur', '=', 'user.id')
                    ->orderBy('user.email', 'asc')
                    ->select('article.*');
                break;
            default:
                $query->orderBy('date_creation', 'desc');
        }

        return $query->get()->toArray();
    }

    public function getArticlesDeAuteurId(int $idAuteur): array
    {
        return Article::where('id_auteur', $idAuteur)->get()->toArray();
    }

    public function updatePublie(int $articleId): void
    {
        $article = Article::find($articleId);

        if (!$article) {
            throw new EntityNotFoundException("Article", $articleId);
        }

        $article->publie = $article->publie ? 0 : 1;
        $article->save();
    }
}

