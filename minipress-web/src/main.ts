import Handlebars from "handlebars";
import { articles as ArticlesApi } from "./api/articles";
import { categories as CategoriesApi } from "./api/categories";

renderAllArticles();

async function renderAllArticles() {
  const api = new ArticlesApi();
  const data = await api.getArticles();

  const response = await fetch("/templates/article-list.hbs");
  const templateSource = await response.text();
  const template = Handlebars.compile(templateSource);

  document.getElementById("app")!.innerHTML = template({ articles: data });
}

async function renderAllCategories() {
  const api = new CategoriesApi();
  const data = await api.getCategories();

  const response = await fetch("/templates/categories-list.hbs");
  const templateSource = await response.text();
  const template = Handlebars.compile(templateSource);

  document.getElementById("app")!.innerHTML = template({ categories: data });
}
