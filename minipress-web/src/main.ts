import Handlebars from "handlebars";
import { articles as ArticlesApi } from "./api/articles";
import { categories as CategoriesApi } from "./api/categories";

const articlesApi = new ArticlesApi();

async function renderCategories() {
  const api = new CategoriesApi();
  const data = await api.getCategories();

  const response = await fetch("/templates/categories-list.hbs");
  const templateSource = await response.text();
  const template = Handlebars.compile(templateSource);

  document.getElementById("categories")!.innerHTML = template({ categories: data });

  document.querySelectorAll(".category-item").forEach((item) => {
    item.addEventListener("click", () => {
      const id = Number((item as HTMLElement).dataset.id);
      renderArticlesByCategory(id);
    });
  });
}

async function renderArticlesByCategory(categoryId: number) {
  const data = await articlesApi.getArticlesByCategory(categoryId);

  const templateSource = document.getElementById("list_template")!.innerHTML;
  const template = Handlebars.compile(templateSource);

  document.getElementById("articles")!.innerHTML = template({ articles: data });
}

renderCategories();
