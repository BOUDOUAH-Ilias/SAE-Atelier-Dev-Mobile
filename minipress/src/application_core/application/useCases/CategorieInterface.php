<?php
namespace minipress\application_core\application\useCases;

interface CategorieInterface {
public function getCategories(): array;
public function getCategorieById(int $id): array;
}

