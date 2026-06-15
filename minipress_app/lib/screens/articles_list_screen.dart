import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/articles_provider.dart';

class ArticlesListScreen extends ConsumerWidget {
  const ArticlesListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncArticles = ref.watch(articlesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: asyncArticles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erreur : $error')),
        data: (articles) => ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return ListTile(
              title: Text(article.titre),
              subtitle: Text('Article #${article.id}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/articles/${article.id}'),
            );
          },
        ),
      ),
    );
  }
}
