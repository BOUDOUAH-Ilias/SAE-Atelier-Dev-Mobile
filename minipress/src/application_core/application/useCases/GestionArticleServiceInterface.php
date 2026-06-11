<?php

declare(strict_types=1);

namespace minipress\application_core\application\useCases;

interface GestionArticleServiceInterface{

    public function createArticle(string $titre, ?string $resume, string $contenu, bool $publie, ?string $imageUrl, int $idCategorie, int $idAuteur): void;

    public function getArticleDesc(): array;

<<<<<<< Updated upstream
    public function getArticles(): array;

    public function getArticleByCategorie(int $idCategorie): array;
=======
        public function getArticles(): array;
>>>>>>> Stashed changes


}
