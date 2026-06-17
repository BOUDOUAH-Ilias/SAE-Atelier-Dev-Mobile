import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/article.dart';
import '../models/article_reduit.dart';
import '../services/api_client.dart';
part 'articles_provider.g.dart';

@riverpod
Future<List<ArticleReduit>> articles(ArticlesRef ref) async {
  final client = ApiClient();
  final data = await client.getArticles();
  return data.map((json) => ArticleReduit.fromApi(json)).toList();
}

@riverpod
Future<Article> articleDetail(ArticleDetailRef ref, int id) async {
  final client = ApiClient();
  final data = await client.getArticleById(id);
  return Article.fromJson(data);
}

final articlesByCategorieProvider =
    FutureProvider.family<List<ArticleReduit>, int>((ref, categorieId) async {
      final client = ApiClient();
      final data = await client.getArticlesByCategorie(categorieId);
      return data.map((json) => ArticleReduit.fromApi(json)).toList();
    });

final articlesByAuteurProvider =
    FutureProvider.family<List<ArticleReduit>, int>((ref, auteurId) async {
      final client = ApiClient();
      final rawArticles = await client.getArticlesByAuteur(auteurId);

      return rawArticles
          .map((item) => ArticleReduit.fromAuteurApi(item))
          .toList();
    });

final articlesSearchProvider =
    FutureProvider.family<List<ArticleReduit>, String>((ref, query) async {
      final client = ApiClient();
      final data = await client.getArticles(q: query.isEmpty ? null : query);
      return data.map(ArticleReduit.fromJson).toList();
    });
