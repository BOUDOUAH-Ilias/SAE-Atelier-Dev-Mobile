import type { ArticleListItem, ArticleDetail, ArticlesResponse, AuthorArticlesResponse } from "../type";

export class Articles {
  private baseUrl: string;

  constructor(baseUrl: string) {
    this.baseUrl = baseUrl;
  }

  async getArticles(): Promise<ArticleListItem[]> {
    const res = await fetch(`${this.baseUrl}api/articles`);
    if (!res.ok) throw new Error(`Erreur HTTP ${res.status}`);
    const data: ArticlesResponse = await res.json();
    return data.articles.sort(
      (a, b) =>
        new Date(b.article.date_creation).getTime() -
        new Date(a.article.date_creation).getTime()
    );
  }

  async getArticlesByCategory(categoryId: number): Promise<ArticleListItem[]> {
    const res = await fetch(`${this.baseUrl}api/categories/${categoryId}/articles`);
    if (!res.ok) throw new Error(`Erreur HTTP ${res.status}`);
    const data: ArticlesResponse = await res.json();
    return data.articles;
  }

  async getArticle(href: string): Promise<ArticleDetail> {
    const res = await fetch(`${this.baseUrl}${href}`);
    if (!res.ok) throw new Error(`Erreur HTTP ${res.status}`);
    const data = await res.json();
    return data.article as ArticleDetail;
  }

  async getArticlesByAuthor(authorId: number): Promise<ArticleListItem[]> {
    const res = await fetch(`${this.baseUrl}api/auteurs/${authorId}/articles`);
    if (!res.ok) throw new Error(`Erreur HTTP ${res.status}`);
    const data: AuthorArticlesResponse = await res.json();
    return data.articles.map((a) => ({
      article: { titre: a.titre, date_creation: a.date_creation, auteur: authorId },
      links: { self: { href: a.url } },
    }));
  }
}
