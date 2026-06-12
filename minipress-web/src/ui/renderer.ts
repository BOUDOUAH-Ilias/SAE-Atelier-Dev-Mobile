import Handlebars from "handlebars";
import type { ArticleListItem, CategoryItem } from "../type";

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

  renderError(message: string): void {
    document.getElementById("articles")!.innerHTML = `<p class="error">${message}</p>`;
  }
}
