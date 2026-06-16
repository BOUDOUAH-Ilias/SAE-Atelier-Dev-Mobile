import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/articles_provider.dart';

class CategoryArticlesScreen extends ConsumerWidget {
  final int categorieId;
  final String? nomCategorie;

  const CategoryArticlesScreen({
    super.key,
    required this.categorieId,
    this.nomCategorie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncArticles = ref.watch(articlesByCategorieProvider(categorieId));
    final titre = nomCategorie ?? 'Catégorie #$categorieId';

    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: asyncArticles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erreur : $error')),
        data: (articles) {
          if (articles.isEmpty) {
            return Center(
              child: Text('Aucun article dans la catégorie "$titre".'),
            );
          }
          return ListView(
            children: articles.map((article) => ListTile(
              title: Text(article.titre),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Article #${article.id}'),
                  Text('Date : ${article.date_creation}'),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/articles/${article.id}'),
            )).toList(),
          );
        },
      ),
    );
  }
}
