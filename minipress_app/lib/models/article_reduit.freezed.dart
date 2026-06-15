// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_reduit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ArticleReduit _$ArticleReduitFromJson(Map<String, dynamic> json) {
  return _ArticleReduit.fromJson(json);
}

/// @nodoc
mixin _$ArticleReduit {
  int get id => throw _privateConstructorUsedError;
  String get titre => throw _privateConstructorUsedError;
  String get date_creation => throw _privateConstructorUsedError;
  @JsonKey(name: 'auteur')
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this ArticleReduit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArticleReduit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArticleReduitCopyWith<ArticleReduit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleReduitCopyWith<$Res> {
  factory $ArticleReduitCopyWith(
    ArticleReduit value,
    $Res Function(ArticleReduit) then,
  ) = _$ArticleReduitCopyWithImpl<$Res, ArticleReduit>;
  @useResult
  $Res call({
    int id,
    String titre,
    String date_creation,
    @JsonKey(name: 'auteur') int userId,
  });
}

/// @nodoc
class _$ArticleReduitCopyWithImpl<$Res, $Val extends ArticleReduit>
    implements $ArticleReduitCopyWith<$Res> {
  _$ArticleReduitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArticleReduit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titre = null,
    Object? date_creation = null,
    Object? userId = null,
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
            date_creation: null == date_creation
                ? _value.date_creation
                : date_creation // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArticleReduitImplCopyWith<$Res>
    implements $ArticleReduitCopyWith<$Res> {
  factory _$$ArticleReduitImplCopyWith(
    _$ArticleReduitImpl value,
    $Res Function(_$ArticleReduitImpl) then,
  ) = __$$ArticleReduitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String titre,
    String date_creation,
    @JsonKey(name: 'auteur') int userId,
  });
}

/// @nodoc
class __$$ArticleReduitImplCopyWithImpl<$Res>
    extends _$ArticleReduitCopyWithImpl<$Res, _$ArticleReduitImpl>
    implements _$$ArticleReduitImplCopyWith<$Res> {
  __$$ArticleReduitImplCopyWithImpl(
    _$ArticleReduitImpl _value,
    $Res Function(_$ArticleReduitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArticleReduit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titre = null,
    Object? date_creation = null,
    Object? userId = null,
  }) {
    return _then(
      _$ArticleReduitImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        titre: null == titre
            ? _value.titre
            : titre // ignore: cast_nullable_to_non_nullable
                  as String,
        date_creation: null == date_creation
            ? _value.date_creation
            : date_creation // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleReduitImpl implements _ArticleReduit {
  const _$ArticleReduitImpl({
    required this.id,
    required this.titre,
    required this.date_creation,
    @JsonKey(name: 'auteur') required this.userId,
  });

  factory _$ArticleReduitImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleReduitImplFromJson(json);

  @override
  final int id;
  @override
  final String titre;
  @override
  final String date_creation;
  @override
  @JsonKey(name: 'auteur')
  final int userId;

  @override
  String toString() {
    return 'ArticleReduit(id: $id, titre: $titre, date_creation: $date_creation, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleReduitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titre, titre) || other.titre == titre) &&
            (identical(other.date_creation, date_creation) ||
                other.date_creation == date_creation) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, titre, date_creation, userId);

  /// Create a copy of ArticleReduit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleReduitImplCopyWith<_$ArticleReduitImpl> get copyWith =>
      __$$ArticleReduitImplCopyWithImpl<_$ArticleReduitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleReduitImplToJson(this);
  }
}

abstract class _ArticleReduit implements ArticleReduit {
  const factory _ArticleReduit({
    required final int id,
    required final String titre,
    required final String date_creation,
    @JsonKey(name: 'auteur') required final int userId,
  }) = _$ArticleReduitImpl;

  factory _ArticleReduit.fromJson(Map<String, dynamic> json) =
      _$ArticleReduitImpl.fromJson;

  @override
  int get id;
  @override
  String get titre;
  @override
  String get date_creation;
  @override
  @JsonKey(name: 'auteur')
  int get userId;

  /// Create a copy of ArticleReduit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArticleReduitImplCopyWith<_$ArticleReduitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
