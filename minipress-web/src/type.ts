export interface Category {
  id: number;
  nom: string;
}

export interface Article {
  id: number;
  titre: string;
  resume: string | null;
  contenu: string;
  date_creation: string;
  publie: number;
  image_url: string | null;
  id_categorie: number;
  id_auteur: number;
}

export interface ArticleListItem {
  article: {
    titre: string;
    date_creation: string;
    auteur: number;
  };
  links: {
    self: { href: string };
  };
}

export interface ArticlesResponse {
  type: string;
  count: number;
  articles: ArticleListItem[];
}