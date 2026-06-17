import type { ArticleListItem } from "./type";
import { Articles } from "./api/articles";
import { Categories } from "./api/categories";
import { Renderer } from "./ui/renderer";
import { API_BASE_URL } from "./conf/conf";

const articlesApi = new Articles(API_BASE_URL);
const categoriesApi = new Categories(API_BASE_URL);
const renderer = new Renderer();

let currentArticles: ArticleListItem[] = [];

function sortBySelected(articles: ArticleListItem[]): ArticleListItem[] {
  const button = document.getElementById("order-button") as HTMLInputElement;
  const sorted = [...articles];
  if (button.innerText == "descendant") {
    sorted.sort((a: ArticleListItem, b: ArticleListItem) => {
      const dateA = new Date(a.article.date_creation);
      const dateB = new Date(b.article.date_creation);
      return dateA.getTime() > dateB.getTime() ? 1 : -1;
    });
  } else if (button.innerText == "ascendant") {
    sorted.sort((a: ArticleListItem, b: ArticleListItem) => {
      const dateA = new Date(a.article.date_creation);
      const dateB = new Date(b.article.date_creation);
      return dateA.getTime() < dateB.getTime() ? 1 : -1;
    });
  }
  return sorted;
}

function displayArticles(articles: ArticleListItem[]): void {
  currentArticles = sortBySelected(articles);
  applyFilter();
}

// Filtrage par mot clé dans le titre ou le résumé (fonction étendue 8).
// Le résumé n'étant pas présent dans la liste renvoyée par l'api, la recherche
// est déléguée à l'api via la query string /api/articles?q=...
async function applyFilter(): Promise<void> {
  const keyword = (
    document.getElementById("filter-input") as HTMLInputElement
  ).value.trim();

  if (!keyword) {
    renderer.renderArticles(currentArticles);
    return;
  }

  try {
    const results = await articlesApi.searchArticles(keyword);
    renderer.renderArticles(sortBySelected(results));
  } catch (e) {
    renderer.renderError("Impossible de filtrer les articles.");
  }
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

async function loadAllArticles(): Promise<void> {
  try {
    displayArticles(await articlesApi.getArticles());
  } catch (e) {
    renderer.renderError("Impossible de charger les articles.");
  }
}

async function loadArticlesByCategory(categoryId: number): Promise<void> {
  try {
    displayArticles(await articlesApi.getArticlesByCategory(categoryId));
  } catch (e) {
    renderer.renderError(
      "Impossible de charger les articles de cette catégorie.",
    );
  }
}

async function loadArticlesByAuthor(authorId: number): Promise<void> {
  try {
    displayArticles(await articlesApi.getArticlesByAuthor(authorId));
  } catch (e) {
    renderer.renderError("Impossible de charger les articles de cet auteur.");
  }
}

const orderButton = document.getElementById("order-button");
orderButton?.addEventListener("click", async () => {
  if (orderButton.innerText == "ascendant") {
    orderButton.innerText = "descendant";
  } else if (orderButton.innerText == "descendant") {
    orderButton.innerText = "ascendant";
  } else {
    console.log("explosion");
  }
  displayArticles(currentArticles);
});
document.getElementById("filter-input")!.addEventListener("input", applyFilter);
document
  .getElementById("btn-all-articles")!
  .addEventListener("click", loadAllArticles);

document
  .getElementById("articles")!
  .addEventListener("click", async (e: MouseEvent) => {
    const target = e.target as HTMLElement;

    if (target.id === "btn-back") {
      applyFilter();
      return;
    }

    const authorLink = target.closest(".author-link");
    if (authorLink) {
      e.preventDefault();
      const id = Number((authorLink as HTMLElement).dataset.id);
      loadArticlesByAuthor(id);
      return;
    }

    const item = target.closest(".article-item");
    if (item) {
      const href = (item as HTMLElement).dataset.href;
      if (!href) return;
      try {
        const article = await articlesApi.getArticle(href);
        renderer.renderArticle(article);
      } catch {
        renderer.renderError("Impossible de charger l'article.");
      }
    }
  });

loadCategories();
loadAllArticles();
