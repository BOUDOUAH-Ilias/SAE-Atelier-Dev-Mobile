import Handlebars from "handlebars";
import type { ArticleListItem } from "./type";
import { articles as ArticlesApi } from "./api/articles";
import { categories as CategoriesApi } from "./api/categories";

const articlesApi = new ArticlesApi();
let currentArticles: ArticleListItem[] = [];

function renderArticles(data: ArticleListItem[]) {
  currentArticles = data;
  applyFilter();
}

function applyFilter() {
  const keyword = (document.getElementById("filter-input") as HTMLInputElement).value.trim().toLowerCase();
  const filtered = keyword
    ? currentArticles.filter((a) => a.article.titre.toLowerCase().includes(keyword))
    : currentArticles;

  const template = Handlebars.compile(document.getElementById("list_template")!.innerHTML);
  document.getElementById("articles")!.innerHTML = template({ articles: filtered });
}

document.getElementById("filter-input")!.addEventListener("input", applyFilter);

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
  renderArticles(await articlesApi.getArticlesByCategory(categoryId));
}

document.getElementById("articles")!.addEventListener("click", (e) => {
  const link = (e.target as HTMLElement).closest(".author-link");
  if (!link) return;
  e.preventDefault();
  const id = Number((link as HTMLElement).dataset.id);
  renderArticlesByAuthor(id);
});

async function renderArticlesByAuthor(authorId: number) {
  renderArticles(await articlesApi.getArticlesByAuthor(authorId));
}

renderCategories();
