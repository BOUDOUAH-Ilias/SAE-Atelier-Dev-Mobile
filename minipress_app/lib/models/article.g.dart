// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      id: (json['id'] as num).toInt(),
      titre: json['titre'] as String? ?? '',
      resume: json['resume'] as String? ?? '',
      contenu: json['contenu'] as String? ?? '',
      date_creation: json['date_creation'] as String? ?? '',
      categorie: (json['categorie'] as num?)?.toInt() ?? 0,
      publie: (json['publie'] as num?)?.toInt() ?? 0,
      userId: (json['id_auteur'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'resume': instance.resume,
      'contenu': instance.contenu,
      'date_creation': instance.date_creation,
      'categorie': instance.categorie,
      'publie': instance.publie,
      'id_auteur': instance.userId,
    };
