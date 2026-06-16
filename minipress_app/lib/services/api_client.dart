import 'package:dio/dio.dart';

class ApiClient {
  static const String _baseUrl =
      'http://docketu.iutnc.univ-lorraine.fr:32327/api';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<Map<String, dynamic>>> getArticles() async {
    final response = await _dio.get('/articles');
    final data = response.data;
    return List<Map<String, dynamic>>.from(data['articles']);
  }

  Future<Map<String, dynamic>> getArticleById(int id) async {
    final response = await _dio.get('/articles/$id');
    final data = response.data;
    return data['article'] as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await _dio.get('/categories');
    final data = response.data;
    return List<Map<String, dynamic>>.from(data['categories']);
  }

  Future<List<Map<String, dynamic>>> getArticlesByCategorie(
    int categorieId,
  ) async {
    final response = await _dio.get(
      '/articles',
      queryParameters: {'categorie': categorieId},
    );
    final data = response.data;
    return List<Map<String, dynamic>>.from(data['articles']);
  }

  Future<Map<String, dynamic>> getAuteurById(int id) async {
    final response = await _dio.get('/auteurs/$id');
    return response.data as Map<String, dynamic>;
  }
}
