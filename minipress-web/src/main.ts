import type { ArticleListItem } from "./type";
import { Articles } from "./api/articles";
import { Categories } from "./api/categories";
import { Renderer } from "./ui/renderer";
import { API_BASE_URL } from "./conf/conf";

const articlesApi = new Articles(API_BASE_URL);
const categoriesApi = new Categories(API_BASE_URL);
const renderer = new Renderer();

let currentArticles: ArticleListItem[] = [];

function displayArticles(articles: ArticleListItem[]): void {
  currentArticles = articles;
  applyFilter();
}

function applyFilter(): void {
  const keyword = (document.getElementById("filter-input") as HTMLInputElement)
    .value.trim().toLowerCase();
  const filtered: ArticleListItem[] = keyword
    ? currentArticles.filter((a) => a.article.titre.toLowerCase().includes(keyword))
    : currentArticles;
  renderer.renderArticles(filtered);
}

async function loadCategories(): Promise<void> {
  try {
    const categories = await categoriesApi.getCategories();
    renderer.renderCategories(categories);
    document.querySelectorAll(".category-item").forEach((item) => {
      item.addEventListener("click", () => {
        const id = Number((item as HTMLElement).dataset.id);
        loadArticlesByCategory(id);
      });
    });
  } catch (e) {
    renderer.renderError("Impossible de charger les catégories.");
  }
}

async function loadArticlesByCategory(categoryId: number): Promise<void> {
  try {
    displayArticles(await articlesApi.getArticlesByCategory(categoryId));
  } catch (e) {
    renderer.renderError("Impossible de charger les articles de cette catégorie.");
  }
}

async function loadArticlesByAuthor(authorId: number): Promise<void> {
  try {
    displayArticles(await articlesApi.getArticlesByAuthor(authorId));
  } catch (e) {
    renderer.renderError("Impossible de charger les articles de cet auteur.");
  }
}

document.getElementById("filter-input")!.addEventListener("input", applyFilter);

document.getElementById("articles")!.addEventListener("click", (e: MouseEvent) => {
  const link = (e.target as HTMLElement).closest(".author-link");
  if (!link) return;
  e.preventDefault();
  const id = Number((link as HTMLElement).dataset.id);
  loadArticlesByAuthor(id);
});

loadCategories();
