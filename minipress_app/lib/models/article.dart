import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  const factory Article({
    required int id,
    @JsonKey(defaultValue: '') required String titre,
    @JsonKey(defaultValue: '') required String resume,
    @JsonKey(defaultValue: '') required String contenu,
    @JsonKey(defaultValue: '') required String date_creation,
    @JsonKey(defaultValue: 0) required int categorie,
    @JsonKey(defaultValue: 0) required int publie,
    @JsonKey(name: 'id_auteur', defaultValue: 0) required int userId,
  }) = _Article;
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
