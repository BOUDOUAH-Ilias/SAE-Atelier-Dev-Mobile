<?php
namespace minipress\application_core\application\useCases;

interface ArticleInterface {
public function getArticles(): array;
public function getArticleById(int $id): array;
}

