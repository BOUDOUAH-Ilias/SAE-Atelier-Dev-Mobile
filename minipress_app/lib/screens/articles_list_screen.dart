// lib/screens/articles_list_screen.dart
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
  bool _sortAscending = false;
  final TextEditingController _controlleurRecherche = TextEditingController();
  String _motrecherche = '';

  @override
  void dispose() {
    _controlleurRecherche.dispose();
    super.dispose();
  }

  List<ArticleReduit> _filteredAndSorted(List<ArticleReduit> articles) {
    var result = [...articles];

    // Filtre par titre
    if (_motrecherche.isNotEmpty) {
      final q = _motrecherche.toLowerCase();
      result = result.where((a) => a.titre.toLowerCase().contains(q)).toList();
    }

    // Tri par date
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
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: TextField(
              controller: _controlleurRecherche,
              decoration: InputDecoration(
                hintText: 'Rechercher dans les titres…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _motrecherche.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controlleurRecherche.clear();
                          setState(() => _motrecherche = '');
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _motrecherche = v),
            ),
          ),
          // Liste
          Expanded(
            child: asyncArticles.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Erreur : $error')),
              data: (articles) {
                final result = _filteredAndSorted(articles);
                if (result.isEmpty) {
                  return const Center(child: Text('Aucun article trouvé.'));
                }
                return ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    final article = result[index];
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
          ),
        ],
      ),
    );
  }
}
