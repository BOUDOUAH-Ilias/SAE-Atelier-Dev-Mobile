import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_reduit.freezed.dart';
part 'article_reduit.g.dart';

@freezed
class ArticleReduit with _$ArticleReduit {
  const factory ArticleReduit({
    required int id,
    required String titre,
    required String date_creation,
    @JsonKey(name: 'auteur') required int userId,
  }) = _ArticleReduit;

  factory ArticleReduit.fromApi(Map<String, dynamic> json) {
    final article = json['article'] as Map<String, dynamic>;
    final href = json['links']['self']['href'] as String;
    final id = int.parse(href.split('/').last);
    return ArticleReduit(
      id: id,
      titre: article['titre'] as String,
      date_creation: article['date_creation'] as String,
      userId: (article['auteur'] as num).toInt(),
    );
  }

  factory ArticleReduit.fromJson(Map<String, dynamic> json) =>
      _$ArticleReduitFromJson(json);
}
