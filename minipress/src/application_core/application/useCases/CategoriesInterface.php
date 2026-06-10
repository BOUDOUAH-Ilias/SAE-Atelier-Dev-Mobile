<?php
namespace gift\appli\application_core\application\useCases;

interface CatalogueInterface {
public function getCategories(): array;
public function getCategorieById(int $id): array;
}

