import Handlebars from "handlebars";
import { articles as ArticlesApi } from "./api/articles";

renderAllArticles();


async function renderAllArticles() {
    const api = new ArticlesApi();
  const data = await api.getArticles();

  const templateSource = document.getElementById("list_template")!.innerHTML;
  const template = Handlebars.compile(templateSource);

  document.getElementById("app")!.innerHTML = template({ articles: data });
}