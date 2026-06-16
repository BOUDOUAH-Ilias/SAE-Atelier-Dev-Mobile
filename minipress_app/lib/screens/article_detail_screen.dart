import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/articles_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/auteur_provider.dart';

class ArticleDetailScreen extends ConsumerWidget {
  final int id;
  const ArticleDetailScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncArticle = ref.watch(articleDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('Détail')),
      body: asyncArticle.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erreur : $error')),
        data: (article) {
          // Le nom de la catégorie est déduit de la liste déjà chargée par
          // categoriesProvider (pas d'appel réseau supplémentaire).
          final asyncCategories = ref.watch(categoriesProvider);
          final nomCategorie = asyncCategories.maybeWhen(
            data: (categories) {
              final correspondantes = categories.where(
                (c) => c.id == article.categorie,
              );
              return correspondantes.isEmpty
                  ? null
                  : correspondantes.first.nom;
            },
            orElse: () => null,
          );

          final asyncNomAuteur = ref.watch(
            auteurNomProvider(article.userId),
          );
          final nomAuteur = asyncNomAuteur.maybeWhen(
            data: (nom) => nom,
            orElse: () => 'Auteur #${article.userId}',
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.titre,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.date_creation,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ActionChip(
                        avatar: const Icon(Icons.category, size: 18),
                        label: Text(nomCategorie ?? 'Catégorie #${article.categorie}'),
                        onPressed: () => context.push(
                          '/categories/${article.categorie}',
                          extra: nomCategorie,
                        ),
                      ),
                      ActionChip(
                        avatar: const Icon(Icons.person, size: 18),
                        label: Text(nomAuteur),
                        onPressed: () => context.push(
                          '/auteurs/${article.userId}',
                          extra: nomAuteur,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.resume,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 16),
                  Text(article.contenu),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
