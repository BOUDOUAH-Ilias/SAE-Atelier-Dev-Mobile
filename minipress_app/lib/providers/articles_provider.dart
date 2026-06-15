import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/article.dart';
import '../services/api_client.dart';
part 'articles_provider.g.dart';

@riverpod
Future<List<Article>> articles(ArticlesRef ref) async {
  final client = ApiClient();
  final data = await client.getArticles();
  return data.map((json) => Article.fromJson(json)).toList();
}

@riverpod
Future<Article> articleDetail(ArticleDetailRef ref, int id) async {
final client = ApiClient();
final data = await client.getArticleById(id);
return Article.fromJson(data);
}

