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
      appBar: AppBar(title: const Text('Article')),
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

          final colorScheme = Theme.of(context).colorScheme;

          return CustomScrollView(
            slivers: [
              // Image de couverture
              if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
                SliverToBoxAdapter(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                    child: Image.network(
                      article.imageUrl!,
                      height: 220,
                      width: double.infinity,
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
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.25,
                            ),
                      ),
                      const SizedBox(height: 12),

                      // Meta : date + chips
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 13,
                            color: colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            article.date_creation.substring(0, 10),
                            style: TextStyle(
                              fontSize: 13,
                              color: colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Chips catégorie + auteur
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ActionChip(
                            avatar: const Icon(
                              Icons.category_outlined,
                              size: 15,
                            ),
                            label: Text(
                              nomCategorie ?? 'Catégorie #${article.categorie}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            onPressed: () => context.push(
                              '/categories/${article.categorie}',
                              extra: nomCategorie,
                            ),
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.person_outline, size: 15),
                            label: Text(
                              nomAuteur,
                              style: const TextStyle(fontSize: 13),
                            ),
                            onPressed: () => context.push(
                              '/auteurs/${article.userId}',
                              extra: nomAuteur,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Résumé
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                          border: Border(
                            left: BorderSide(
                              color: colorScheme.primary,
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
                      const SizedBox(height: 20),
                      Divider(color: colorScheme.outlineVariant),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              // Contenu Markdown
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
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
                          ).textTheme.bodyMedium?.copyWith(height: 1.65),
                          blockquoteDecoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            border: Border(
                              left: BorderSide(
                                color: colorScheme.secondary,
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
