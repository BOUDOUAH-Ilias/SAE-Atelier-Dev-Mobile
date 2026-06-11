import type { Category } from "../type";
import { API_BASE_URL } from "../conf/conf";

export class categories {
  async getCategories(): Promise<Category[]> {
    return fetch(API_BASE_URL + "api/categories")
      .then((res: Response) => {
        return res.json() as Promise<Category[]>;
      })
      .then((data: Category[]) => {
        return data;
      });
  }
}
