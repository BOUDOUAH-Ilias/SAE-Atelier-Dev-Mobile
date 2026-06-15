// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(articles)
final articlesProvider = ArticlesProvider._();

final class ArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          FutureOr<List<Article>>
        >
    with $FutureModifier<List<Article>>, $FutureProvider<List<Article>> {
  ArticlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'articlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$articlesHash();

  @$internal
  @override
  $FutureProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Article>> create(Ref ref) {
    return articles(ref);
  }
}

String _$articlesHash() => r'52d29f0082224bee9550e79d7c41eb382b3ed6fd';

@ProviderFor(articleDetail)
final articleDetailProvider = ArticleDetailFamily._();

final class ArticleDetailProvider
    extends $FunctionalProvider<AsyncValue<Article>, Article, FutureOr<Article>>
    with $FutureModifier<Article>, $FutureProvider<Article> {
  ArticleDetailProvider._({
    required ArticleDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'articleDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleDetailHash();

  @override
  String toString() {
    return r'articleDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Article> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Article> create(Ref ref) {
    final argument = this.argument as int;
    return articleDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleDetailHash() => r'ac5544c3df01fd285119ba5d5ce2cd743b6788b0';

final class ArticleDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Article>, int> {
  ArticleDetailFamily._()
    : super(
        retry: null,
        name: r'articleDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleDetailProvider call(int id) =>
      ArticleDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'articleDetailProvider';
}
