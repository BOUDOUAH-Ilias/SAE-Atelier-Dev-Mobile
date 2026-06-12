import type { CategoryItem, CategoriesResponse } from "../type";
import { API_BASE_URL } from "../conf/conf";

export class categories {
  async getCategories(): Promise<CategoryItem[]> {
    return fetch(API_BASE_URL + "api/categories")
      .then((res: Response) => {
        return res.json() as Promise<CategoriesResponse>;
      })
      .then((data: CategoriesResponse) => {
        return data.categories;
      });
  }
}
