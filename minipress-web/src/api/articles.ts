import type { Article } from "../type";
import { API_BASE_URL } from "../conf/conf";

export class articles {


     async getArticles() : Promise<Article[]> {

       return fetch(API_BASE_URL + "api/articles")
        .then((res : Response)=>{
            return res.json() as Promise<Article[]>;
        })
        .then((data : Article[])=>{
            return data;
        })
}
}