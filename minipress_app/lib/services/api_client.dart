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

  Future<List<Map<String, dynamic>>> getArticles({String? q}) async {
    final queryParams = <String, dynamic>{};
    if (q != null && q.isNotEmpty) queryParams['q'] = q;

    final response = await _dio.get(
      '/articles',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
    final data = response.data;
    final raw = List<dynamic>.from(data['articles']);

    // L'API peut retourner soit une liste plate {titre, date_creation, ...}
    // soit la structure wrappée {article: {...}, links: {...}}.
    // On normalise dans les deux cas.
    return raw.map((item) {
      final map = item as Map<String, dynamic>;
      if (map.containsKey('article')) {
        // Structure wrappée — on extrait et on injecte l'id depuis le lien
        final inner = Map<String, dynamic>.from(
          map['article'] as Map<String, dynamic>,
        );
        // Extraire l'id depuis "links.self.href" = "api/articles/42"
        final href = map['links']?['self']?['href'] as String?;
        if (href != null && !inner.containsKey('id')) {
          final parts = href.split('/');
          final idStr = parts.isNotEmpty ? parts.last : null;
          if (idStr != null) inner['id'] = int.tryParse(idStr) ?? 0;
        }
        // Normaliser le champ auteur
        if (inner.containsKey('auteur') && !inner.containsKey('id_auteur')) {
          inner['id_auteur'] = inner['auteur'];
        }
        return inner;
      }
      // Structure plate déjà correcte
      return map;
    }).toList();
  }

  Future<Map<String, dynamic>> getArticleById(int id) async {
    final response = await _dio.get('/articles/$id');
    final data = response.data['article'] as Map<String, dynamic>;

    if (data.containsKey('auteur') && !data.containsKey('id_auteur')) {
      data['id_auteur'] = data['auteur'];
    }

    return data;
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await _dio.get('/categories');
    final data = response.data;
    return List<Map<String, dynamic>>.from(data['categories']);
  }

  Future<List<Map<String, dynamic>>> getArticlesByCategorie(
    int categorieId,
  ) async {
    final response = await _dio.get('/categories/$categorieId/articles');
    final data = response.data;
    return List<Map<String, dynamic>>.from(data['articles']);
  }

  Future<Map<String, dynamic>> getAuteurById(int id) async {
    final response = await _dio.get('/auteurs/$id');
    return response.data as Map<String, dynamic>;
  }
}
