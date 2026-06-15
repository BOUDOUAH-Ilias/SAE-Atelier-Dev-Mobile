// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_reduit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleReduitImpl _$$ArticleReduitImplFromJson(Map<String, dynamic> json) =>
    _$ArticleReduitImpl(
      id: (json['id'] as num).toInt(),
      titre: json['titre'] as String,
      date_creation: json['date_creation'] as String,
      userId: (json['auteur'] as num).toInt(),
    );

Map<String, dynamic> _$$ArticleReduitImplToJson(_$ArticleReduitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'date_creation': instance.date_creation,
      'auteur': instance.userId,
    };
