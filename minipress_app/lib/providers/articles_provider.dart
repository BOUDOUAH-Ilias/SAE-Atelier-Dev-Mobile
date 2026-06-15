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
