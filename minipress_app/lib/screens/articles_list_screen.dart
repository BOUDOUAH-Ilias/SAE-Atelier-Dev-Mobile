import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/article_reduit.dart';
import '../providers/articles_provider.dart';

class ArticlesListScreen extends ConsumerStatefulWidget {
  const ArticlesListScreen({super.key});

  @override
  ConsumerState<ArticlesListScreen> createState() => _ArticlesListScreenState();
}

class _ArticlesListScreenState extends ConsumerState<ArticlesListScreen> {
  bool _sortAscending = false; // false = plus récent en premier (défaut sujet)

  List<ArticleReduit> _sorted(List<ArticleReduit> articles) {
    final result = [...articles]; // copie pour ne pas muter l'original
    result.sort(
      (a, b) => _sortAscending
          ? a.date_creation.compareTo(b.date_creation)
          : b.date_creation.compareTo(a.date_creation),
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final asyncArticles = ref.watch(articlesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        actions: [
          IconButton(
            tooltip: _sortAscending
                ? 'Tri : ancien → récent'
                : 'Tri : récent → ancien',
            icon: Icon(
              _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
            ),
            onPressed: () => setState(() => _sortAscending = !_sortAscending),
          ),
        ],
      ),
      body: asyncArticles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erreur : $error')),
        data: (articles) {
          final sorted = _sorted(articles);
          return ListView.builder(
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final article = sorted[index];
              return ListTile(
                title: Text(article.titre),
                subtitle: Text(article.date_creation),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/articles/${article.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
