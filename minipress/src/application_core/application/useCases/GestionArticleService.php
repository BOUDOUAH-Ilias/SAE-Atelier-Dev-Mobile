<?php


namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\Article;
use minipress\application_core\application\exceptions\EntityNotFoundException;
use Override;

class GestionArticleService implements GestionArticleServiceInterface
{

    public function createArticle(string $titre, ?string $resume, string $contenu, bool $publie, ?string $imageUrl, int $idCategorie, int $idAuteur): void
    {
        if (empty(trim($titre))) {
            throw new \InvalidArgumentException('Le titre est obligatoire');
        }
        if (strlen($titre) > 255) {
            throw new \InvalidArgumentException('Le titre ne peut pas dépasser 255 caractères');
        }
        if (empty(trim($contenu))) {
            throw new \InvalidArgumentException('Le contenu est obligatoire');
        }
        if ($idCategorie <= 0) {
            throw new \InvalidArgumentException('Veuillez choisir une catégorie valide');
        }
        if ($imageUrl !== null && $imageUrl !== '' && !filter_var($imageUrl, FILTER_VALIDATE_URL)) {
            throw new \InvalidArgumentException("L'URL de l'image est invalide");
        }

        $article = new Article();
        $article->titre = trim($titre);
        $article->resume = $resume !== null ? trim($resume) : null;
        $article->contenu = trim($contenu);
        $article->publie = $publie;
        $article->image_url = ($imageUrl !== '' ? $imageUrl : null);
        $article->id_categorie = $idCategorie;
        $article->id_auteur = $idAuteur;
        $article->save();
    }

    public function getArticleDesc(): array
    {
        return Article::orderBy('date_creation', 'desc')->where('publie', 1)->get()->toArray();
    }

    public function getAllArticles(): array
    {
        return Article::orderBy('date_creation', 'desc')->get()->toArray();
    }

    public function getArticlesForUser(int $userId): array
    {
        return Article::where('publie', 1)
            ->orWhere('id_auteur', $userId)
            ->orderBy('date_creation', 'desc')
            ->get()->toArray();
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

