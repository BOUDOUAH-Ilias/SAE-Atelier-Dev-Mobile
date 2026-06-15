import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/articles_provider.dart';

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
        data: (article) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(article.body),
            ],
          ),
        ),
      ),
    );
  }
}
