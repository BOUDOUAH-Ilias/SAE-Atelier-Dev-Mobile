import 'package:freezed_annotation/freezed_annotation.dart';

part 'categorie.freezed.dart';
part 'categorie.g.dart';

@freezed
class Categorie with _$Categorie {
  const factory Categorie({
    required int id,
    required String nom,
  }) = _Categorie;

  factory Categorie.fromApi(Map<String, dynamic> json) {
    final categorie = json['categorie'] as Map<String, dynamic>;

    return Categorie(
      id: categorie['id'] as int,
      nom: categorie['nom'] as String,
    );
  }

  factory Categorie.fromJson(Map<String, dynamic> json) =>
      _$CategorieFromJson(json);
}