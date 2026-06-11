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