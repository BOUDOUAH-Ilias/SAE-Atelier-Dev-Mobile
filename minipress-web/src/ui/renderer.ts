import Handlebars from "handlebars";
import { marked } from "marked";
import type { ArticleDetail, ArticleListItem, CategoryItem } from "../type";

const esc = (s: string): string =>
  s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

const md = (s: string): string => marked.parse(s) as string;

export class Renderer {
  private getTemplate(id: string): HandlebarsTemplateDelegate {
    const source = document.getElementById(id)!.innerHTML;
    return Handlebars.compile(source);
  }

  renderCategories(categories: CategoryItem[]): void {
    const template = this.getTemplate("categories_template");
    document.getElementById("categories")!.innerHTML = template({ categories });
  }

  renderArticles(articles: ArticleListItem[]): void {
    const template = this.getTemplate("list_template");
    document.getElementById("articles")!.innerHTML = template({ articles });
  }

  renderArticle(article: ArticleDetail): void {
    const img = article.image_url
      ? `<img class="article-img" src="${esc(article.image_url)}" alt="">`
      : "";
    const resume = article.resume
      ? `<div class="article-resume">${md(article.resume)}</div>`
      : "";

    document.getElementById("articles")!.innerHTML = `
      <button id="btn-back">← Retour</button>
      <article class="article-detail">
        <h1>${esc(article.titre)}</h1>
        <p class="article-date">${esc(article.date_creation)}</p>
        ${img}
        ${resume}
        <div class="article-content">${md(article.contenu)}</div>
      </article>
    `;
  }

  renderError(message: string): void {
    document.getElementById("articles")!.innerHTML = `<p class="error">${message}</p>`;
  }
}
