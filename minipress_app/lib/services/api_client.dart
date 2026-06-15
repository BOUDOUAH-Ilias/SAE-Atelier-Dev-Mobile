import 'package:dio/dio.dart';

class ApiClient {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  Future<List<Map<String, dynamic>>> getArticles() async {
    final response = await _dio.get('/posts');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> getArticleById(int id) async {
    final response = await _dio.get('/posts/$id');
    return response.data as Map<String, dynamic>;
  }
}
