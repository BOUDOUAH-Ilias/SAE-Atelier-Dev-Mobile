import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
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
          final asyncCategories = ref.watch(categoriesProvider);
          final nomCategorie = asyncCategories.maybeWhen(
            data: (categories) {
              final correspondantes = categories.where(
                (c) => c.id == article.categorie,
              );
              return correspondantes.isEmpty ? null : correspondantes.first.nom;
            },
            orElse: () => null,
          );

          final asyncNomAuteur = ref.watch(auteurNomProvider(article.userId));
          final nomAuteur = asyncNomAuteur.maybeWhen(
            data: (nom) => nom,
            orElse: () => 'Auteur #${article.userId}',
          );

          return CustomScrollView(
            slivers: [
              // Image de couverture en SliverAppBar si image_url présente
              if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 220,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      article.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre
                      Text(
                        article.titre,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),

                      // Date
                      Text(
                        article.date_creation,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.55),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Chips catégorie + auteur
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ActionChip(
                            avatar: const Icon(Icons.category, size: 16),
                            label: Text(
                              nomCategorie ?? 'Catégorie #${article.categorie}',
                            ),
                            onPressed: () => context.push(
                              '/categories/${article.categorie}',
                              extra: nomCategorie,
                            ),
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.person, size: 16),
                            label: Text(nomAuteur),
                            onPressed: () => context.push(
                              '/auteurs/${article.userId}',
                              extra: nomAuteur,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Résumé rendu en Markdown
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                          border: Border(
                            left: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3,
                            ),
                          ),
                        ),
                        child: MarkdownBody(
                          data: article.resume,
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(
                                Theme.of(context),
                              ).copyWith(
                                p: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              ),
                          onTapLink: (text, href, title) => _openUrl(href),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Divider avant le contenu
                      const Divider(height: 1),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Contenu Markdown avec support des images réseau
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: MarkdownBody(
                    data: article.contenu,
                    selectable: true,
                    imageBuilder: (uri, title, alt) =>
                        _NetworkImageWidget(uri: uri, alt: alt),
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(
                          h2: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          h3: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          p: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(height: 1.6),
                          blockquoteDecoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            border: Border(
                              left: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                    onTapLink: (text, href, title) => _openUrl(href),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openUrl(String? href) async {
    if (href == null) return;
    final uri = Uri.tryParse(href);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Widget pour afficher les images réseau issues du Markdown,
/// avec placeholder de chargement et fallback en cas d'erreur.
class _NetworkImageWidget extends StatelessWidget {
  final Uri uri;
  final String? alt;

  const _NetworkImageWidget({required this.uri, this.alt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          uri.toString(),
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 180,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            if (alt == null || alt!.isEmpty) return const SizedBox.shrink();
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.broken_image_outlined,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      alt!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
