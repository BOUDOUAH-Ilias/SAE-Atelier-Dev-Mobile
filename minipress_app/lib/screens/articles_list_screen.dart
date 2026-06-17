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
  bool _searchVisible = false;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ArticleReduit> _sorted(List<ArticleReduit> articles) {
    final result = [...articles];
    result.sort(
      (a, b) => _sortAscending
          ? a.date_creation.compareTo(b.date_creation)
          : b.date_creation.compareTo(a.date_creation),
    );
    return result;
  }

  void _toggleSearch() {
    setState(() {
      _searchVisible = !_searchVisible;
      if (!_searchVisible) {
        _searchController.clear();
        _query = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncArticles = ref.watch(articlesSearchProvider(_query));
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: _searchVisible
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Rechercher dans titres et résumés…',
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() => _query = value),
              )
            : const Text(
                'MiniPress',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
        actions: [
          IconButton(
            tooltip: _searchVisible ? 'Fermer la recherche' : 'Rechercher',
            icon: Icon(_searchVisible ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
          if (!_searchVisible)
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
          // Indicateur de recherche active
          if (_query.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: colorScheme.primaryContainer,
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 14,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Résultats pour « $_query »',
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: asyncArticles.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Erreur : $error')),
              data: (articles) {
                if (articles.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: colorScheme.outline,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _query.isNotEmpty
                              ? 'Aucun article pour « $_query »'
                              : 'Aucun article disponible',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                }
                final sorted = _sorted(articles);
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  itemCount: sorted.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final article = sorted[index];
                    final asyncNomAuteur = ref.watch(
                      auteurNomProvider(article.userId),
                    );
                    final nomAuteur = asyncNomAuteur.maybeWhen(
                      data: (nom) => nom,
                      orElse: () => 'Auteur #${article.userId}',
                    );
                    return Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => context.go('/articles/${article.id}'),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.titre,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          size: 12,
                                          color: colorScheme.outline,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          article.date_creation.substring(
                                            0,
                                            10,
                                          ),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: colorScheme.outline,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Icon(
                                          Icons.person_outline,
                                          size: 12,
                                          color: colorScheme.outline,
                                        ),
                                        const SizedBox(width: 4),
                                        GestureDetector(
                                          onTap: () => context.push(
                                            '/auteurs/${article.userId}',
                                            extra: nomAuteur,
                                          ),
                                          child: Text(
                                            nomAuteur,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: colorScheme.primary,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: colorScheme.outlineVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CATÉGORIES',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 36,
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
                children: categories
                    .map(
                      (categorie) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          label: Text(
                            categorie.nom,
                            style: const TextStyle(fontSize: 13),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          onPressed: () => context.push(
                            '/categories/${categorie.id}',
                            extra: categorie.nom,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
