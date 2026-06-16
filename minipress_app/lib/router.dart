import 'package:go_router/go_router.dart';
import 'screens/articles_list_screen.dart';
import 'screens/article_detail_screen.dart';
import 'screens/category_articles_screen.dart';
import 'screens/author_articles_screen.dart';

final router = GoRouter(
  initialLocation: '/articles',
  routes: [
    GoRoute(
      path: '/articles',
      builder: (context, state) => const ArticlesListScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return ArticleDetailScreen(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/categories/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final nomCategorie = state.extra as String?;
        return CategoryArticlesScreen(
          categorieId: id,
          nomCategorie: nomCategorie,
        );
      },
    ),
    GoRoute(
      path: '/auteurs/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final nomAuteur = state.extra as String?;
        return AuthorArticlesScreen(auteurId: id, nomAuteur: nomAuteur);
      },
    ),
  ],
);
