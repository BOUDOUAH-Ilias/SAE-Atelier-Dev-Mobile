// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
mixin _$Article {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get titre => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get resume => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get contenu => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get date_creation => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get categorie => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get publie => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_auteur', defaultValue: 0)
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Article to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res, Article>;
  @useResult
  $Res call({
    int id,
    @JsonKey(defaultValue: '') String titre,
    @JsonKey(defaultValue: '') String resume,
    @JsonKey(defaultValue: '') String contenu,
    @JsonKey(defaultValue: '') String date_creation,
    @JsonKey(defaultValue: 0) int categorie,
    @JsonKey(defaultValue: 0) int publie,
    @JsonKey(name: 'id_auteur', defaultValue: 0) int userId,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res, $Val extends Article>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titre = null,
    Object? resume = null,
    Object? contenu = null,
    Object? date_creation = null,
    Object? categorie = null,
    Object? publie = null,
    Object? userId = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            titre: null == titre
                ? _value.titre
                : titre // ignore: cast_nullable_to_non_nullable
                      as String,
            resume: null == resume
                ? _value.resume
                : resume // ignore: cast_nullable_to_non_nullable
                      as String,
            contenu: null == contenu
                ? _value.contenu
                : contenu // ignore: cast_nullable_to_non_nullable
                      as String,
            date_creation: null == date_creation
                ? _value.date_creation
                : date_creation // ignore: cast_nullable_to_non_nullable
                      as String,
            categorie: null == categorie
                ? _value.categorie
                : categorie // ignore: cast_nullable_to_non_nullable
                      as int,
            publie: null == publie
                ? _value.publie
                : publie // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArticleImplCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$ArticleImplCopyWith(
    _$ArticleImpl value,
    $Res Function(_$ArticleImpl) then,
  ) = __$$ArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(defaultValue: '') String titre,
    @JsonKey(defaultValue: '') String resume,
    @JsonKey(defaultValue: '') String contenu,
    @JsonKey(defaultValue: '') String date_creation,
    @JsonKey(defaultValue: 0) int categorie,
    @JsonKey(defaultValue: 0) int publie,
    @JsonKey(name: 'id_auteur', defaultValue: 0) int userId,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class __$$ArticleImplCopyWithImpl<$Res>
    extends _$ArticleCopyWithImpl<$Res, _$ArticleImpl>
    implements _$$ArticleImplCopyWith<$Res> {
  __$$ArticleImplCopyWithImpl(
    _$ArticleImpl _value,
    $Res Function(_$ArticleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titre = null,
    Object? resume = null,
    Object? contenu = null,
    Object? date_creation = null,
    Object? categorie = null,
    Object? publie = null,
    Object? userId = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$ArticleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        titre: null == titre
            ? _value.titre
            : titre // ignore: cast_nullable_to_non_nullable
                  as String,
        resume: null == resume
            ? _value.resume
            : resume // ignore: cast_nullable_to_non_nullable
                  as String,
        contenu: null == contenu
            ? _value.contenu
            : contenu // ignore: cast_nullable_to_non_nullable
                  as String,
        date_creation: null == date_creation
            ? _value.date_creation
            : date_creation // ignore: cast_nullable_to_non_nullable
                  as String,
        categorie: null == categorie
            ? _value.categorie
            : categorie // ignore: cast_nullable_to_non_nullable
                  as int,
        publie: null == publie
            ? _value.publie
            : publie // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleImpl implements _Article {
  const _$ArticleImpl({
    required this.id,
    @JsonKey(defaultValue: '') required this.titre,
    @JsonKey(defaultValue: '') required this.resume,
    @JsonKey(defaultValue: '') required this.contenu,
    @JsonKey(defaultValue: '') required this.date_creation,
    @JsonKey(defaultValue: 0) required this.categorie,
    @JsonKey(defaultValue: 0) required this.publie,
    @JsonKey(name: 'id_auteur', defaultValue: 0) required this.userId,
    @JsonKey(name: 'image_url') required this.imageUrl,
  });

  factory _$ArticleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(defaultValue: '')
  final String titre;
  @override
  @JsonKey(defaultValue: '')
  final String resume;
  @override
  @JsonKey(defaultValue: '')
  final String contenu;
  @override
  @JsonKey(defaultValue: '')
  final String date_creation;
  @override
  @JsonKey(defaultValue: 0)
  final int categorie;
  @override
  @JsonKey(defaultValue: 0)
  final int publie;
  @override
  @JsonKey(name: 'id_auteur', defaultValue: 0)
  final int userId;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'Article(id: $id, titre: $titre, resume: $resume, contenu: $contenu, date_creation: $date_creation, categorie: $categorie, publie: $publie, userId: $userId, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titre, titre) || other.titre == titre) &&
            (identical(other.resume, resume) || other.resume == resume) &&
            (identical(other.contenu, contenu) || other.contenu == contenu) &&
            (identical(other.date_creation, date_creation) ||
                other.date_creation == date_creation) &&
            (identical(other.categorie, categorie) ||
                other.categorie == categorie) &&
            (identical(other.publie, publie) || other.publie == publie) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    titre,
    resume,
    contenu,
    date_creation,
    categorie,
    publie,
    userId,
    imageUrl,
  );

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      __$$ArticleImplCopyWithImpl<_$ArticleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleImplToJson(this);
  }
}

abstract class _Article implements Article {
  const factory _Article({
    required final int id,
    @JsonKey(defaultValue: '') required final String titre,
    @JsonKey(defaultValue: '') required final String resume,
    @JsonKey(defaultValue: '') required final String contenu,
    @JsonKey(defaultValue: '') required final String date_creation,
    @JsonKey(defaultValue: 0) required final int categorie,
    @JsonKey(defaultValue: 0) required final int publie,
    @JsonKey(name: 'id_auteur', defaultValue: 0) required final int userId,
    @JsonKey(name: 'image_url') required final String? imageUrl,
  }) = _$ArticleImpl;

  factory _Article.fromJson(Map<String, dynamic> json) = _$ArticleImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(defaultValue: '')
  String get titre;
  @override
  @JsonKey(defaultValue: '')
  String get resume;
  @override
  @JsonKey(defaultValue: '')
  String get contenu;
  @override
  @JsonKey(defaultValue: '')
  String get date_creation;
  @override
  @JsonKey(defaultValue: 0)
  int get categorie;
  @override
  @JsonKey(defaultValue: 0)
  int get publie;
  @override
  @JsonKey(name: 'id_auteur', defaultValue: 0)
  int get userId;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of Article
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
