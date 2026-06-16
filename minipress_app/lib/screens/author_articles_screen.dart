import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/articles_provider.dart';
import '../providers/auteur_provider.dart';

class AuthorArticlesScreen extends ConsumerWidget {
  final int auteurId;
  final String? nomAuteur;

  const AuthorArticlesScreen({
    super.key,
    required this.auteurId,
    this.nomAuteur,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncArticles = ref.watch(articlesByAuteurProvider(auteurId));

    final titre =
        nomAuteur ??
        ref
            .watch(auteurNomProvider(auteurId))
            .maybeWhen(data: (nom) => nom, orElse: () => 'Auteur #$auteurId');

    return Scaffold(
      appBar: AppBar(title: Text(titre ?? 'Titre')),
      body: asyncArticles.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erreur : $error')),
        data: (articles) {
          if (articles.isEmpty) {
            return Center(child: Text('Aucun article de "$titre".'));
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
