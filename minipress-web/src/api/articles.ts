import type { ArticleListItem, ArticlesResponse } from "../type";
import { API_BASE_URL } from "../conf/conf";

export class articles {

  async getArticles(): Promise<ArticleListItem[]> {
    return fetch(API_BASE_URL + "api/articles")
      .then((res: Response) => res.json() as Promise<ArticlesResponse>)
      .then((data: ArticlesResponse) =>
        data.articles.sort(
          (a, b) =>
            new Date(b.article.date_creation).getTime() -
            new Date(a.article.date_creation).getTime()
        )
      );
  }
}