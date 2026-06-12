import type { ArticleListItem, ArticlesResponse, AuthorArticlesResponse } from "../type";
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

  async getArticlesByCategory(categoryId: number): Promise<ArticleListItem[]> {
    return fetch(API_BASE_URL + `api/categories/${categoryId}/articles`)
      .then((res: Response) => res.json() as Promise<ArticlesResponse>)
      .then((data: ArticlesResponse) => data.articles);
  }

  async getArticlesByAuthor(authorId: number): Promise<ArticleListItem[]> {
  return fetch(API_BASE_URL + `api/auteurs/${authorId}/articles`)
    .then((res) => res.json() as Promise<AuthorArticlesResponse>)
    .then((data) =>
      data.articles.map((a) => ({
        article: { titre: a.titre, date_creation: a.date_creation, auteur: authorId },
        links: { self: { href: a.url } },
      }))
    );
}
}