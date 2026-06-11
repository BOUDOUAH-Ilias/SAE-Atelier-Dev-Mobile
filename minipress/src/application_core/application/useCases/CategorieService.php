<?php

namespace minipress\application_core\application\useCases;

use minipress\application_core\domain\entities\Categorie;
use minipress\application_core\application\useCases\CategorieInterface;

class CategorieService implements CategorieInterface {

    public function getCategories(): array {
        return Categorie::all()->toArray();
    }

    public function createCategorie(string $nom): void {
        $categorie = new Categorie();
        $categorie->nom = $nom;
        $categorie->save();
    }

    public function getCategorieById(int $id): array {
        try {
            return Categorie::findOrFail($id)->toArray();
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            throw new EntityNotFoundException("Catégorie", $id);
        }
    }
}