import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/article_reduit.dart';
import '../providers/articles_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/auteur_provider.dart';

class ArticlesListScreen extends ConsumerStatefulWidget {
  const ArticlesListScreen({super.key});

  @override
  ConsumerState<ArticlesListScreen> createState() => _ArticlesListScreenState();
}

class _ArticlesListScreenState extends ConsumerState<ArticlesListScreen> {
  bool _sortAscending = false;

  List<ArticleReduit> _sorted(List<ArticleReduit> articles) {
    final result = [...articles];
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
      body: Column(
        children: [
          const _CategoriesZone(),
          const Divider(height: 1),
          Expanded(
            child: asyncArticles.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Erreur : $error')),
              data: (articles) {
                final sorted = _sorted(articles);
                return ListView(
                  children: sorted.map((article) {
                    final asyncNomAuteur = ref.watch(
                      auteurNomProvider(article.userId),
                    );
                    final nomAuteur = asyncNomAuteur.maybeWhen(
                      data: (nom) => nom,
                      orElse: () => 'Auteur #${article.userId}',
                    );
                    return ListTile(
                      title: Text(article.titre),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Article #${article.id}'),
                          Text('Date : ${article.date_creation}'),
                          GestureDetector(
                            onTap: () => context.push(
                              '/auteurs/${article.userId}',
                              extra: nomAuteur,
                            ),
                            child: Text(
                              'Auteur : $nomAuteur',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.go('/articles/${article.id}'),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesZone extends ConsumerWidget {
  const _CategoriesZone();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategories = ref.watch(categoriesProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Catégories',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: asyncCategories.when(
              loading: () => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (error, _) => Center(
                child: Text(
                  'Erreur catégories : $error',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              data: (categories) => ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: categories.map((categorie) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(categorie.nom),
                    onPressed: () => context.push(
                      '/categories/${categorie.id}',
                      extra: categorie.nom,
                    ),
                  ),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
