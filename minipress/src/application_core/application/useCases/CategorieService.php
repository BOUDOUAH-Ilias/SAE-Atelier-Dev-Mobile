<?php

namespace minipress\application_core\application\useCases;

use gift\appli\application_core\domain\entities\Categorie;

class CategorieService implements CategorieInterface {

    public function getCategories(): array {
        return Categorie::all()->toArray();
    }

    public function getCategorieById(int $id): array {
        try {
            return Categorie::findOrFail($id)->toArray();
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            throw new EntityNotFoundException("Catégorie", $id);
        }
    }
}