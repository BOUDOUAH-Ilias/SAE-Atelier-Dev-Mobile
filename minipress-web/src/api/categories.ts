import type { CategoryItem, CategoriesResponse } from "../type";

export class Categories {
  private baseUrl: string;

  constructor(baseUrl: string) {
    this.baseUrl = baseUrl;
  }

  async getCategories(): Promise<CategoryItem[]> {
    const res = await fetch(`${this.baseUrl}api/categories`);
    if (!res.ok) throw new Error(`Erreur HTTP ${res.status}`);
    const data: CategoriesResponse = await res.json();
    return data.categories;
  }
}
