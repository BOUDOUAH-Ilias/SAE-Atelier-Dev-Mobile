import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/categorie.dart';
import '../services/api_client.dart';

part 'categories_provider.g.dart';

@riverpod
Future<List<Categorie>> categories(CategoriesRef ref) async {
  final client = ApiClient();
  final data = await client.getCategories();

  return data.map((json) => Categorie.fromApi(json)).toList();
}