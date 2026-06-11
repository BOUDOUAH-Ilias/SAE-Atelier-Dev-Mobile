# SAE-Atelier-Dev-Mobile

## Groupe

- ANTZORN Hugo
- BOUDOUAH Iliad
- AIME--CABOCEL Léandre
- DELATTRE Maxence

## Routes disponibles

### Interface web

| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/` | Page d'accueil |
| GET | `/articles` | Liste de tous les articles |
| GET | `/articles/categorie/{id}` | Liste des articles par catégorie |
| GET | `/article/create` | Formulaire de création d'article |
| POST | `/article/create` | Soumission du formulaire de création d'article |
| GET | `/categorie/create` | Formulaire de création de catégorie |
| POST | `/categorie/create` | Soumission du formulaire de création de catégorie |

### API

| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/api/categories` | Récupérer toutes les catégories |
| GET | `/api/categories/{id}/articles` | Récupérer les articles d'une catégorie |
| GET | `/api/articles` | Récupérer tous les articles |
| GET | `/api/articles/{id}` | Récupérer un article par son identifiant |