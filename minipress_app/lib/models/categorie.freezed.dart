// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categorie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Categorie _$CategorieFromJson(Map<String, dynamic> json) {
  return _Categorie.fromJson(json);
}

/// @nodoc
mixin _$Categorie {
  int get id => throw _privateConstructorUsedError;
  String get nom => throw _privateConstructorUsedError;

  /// Serializes this Categorie to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Categorie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategorieCopyWith<Categorie> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorieCopyWith<$Res> {
  factory $CategorieCopyWith(Categorie value, $Res Function(Categorie) then) =
      _$CategorieCopyWithImpl<$Res, Categorie>;
  @useResult
  $Res call({int id, String nom});
}

/// @nodoc
class _$CategorieCopyWithImpl<$Res, $Val extends Categorie>
    implements $CategorieCopyWith<$Res> {
  _$CategorieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Categorie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? nom = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategorieImplCopyWith<$Res>
    implements $CategorieCopyWith<$Res> {
  factory _$$CategorieImplCopyWith(
    _$CategorieImpl value,
    $Res Function(_$CategorieImpl) then,
  ) = __$$CategorieImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String nom});
}

/// @nodoc
class __$$CategorieImplCopyWithImpl<$Res>
    extends _$CategorieCopyWithImpl<$Res, _$CategorieImpl>
    implements _$$CategorieImplCopyWith<$Res> {
  __$$CategorieImplCopyWithImpl(
    _$CategorieImpl _value,
    $Res Function(_$CategorieImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Categorie
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? nom = null}) {
    return _then(
      _$CategorieImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CategorieImpl implements _Categorie {
  const _$CategorieImpl({required this.id, required this.nom});

  factory _$CategorieImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategorieImplFromJson(json);

  @override
  final int id;
  @override
  final String nom;

  @override
  String toString() {
    return 'Categorie(id: $id, nom: $nom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorieImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nom, nom) || other.nom == nom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nom);

  /// Create a copy of Categorie
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorieImplCopyWith<_$CategorieImpl> get copyWith =>
      __$$CategorieImplCopyWithImpl<_$CategorieImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategorieImplToJson(this);
  }
}

abstract class _Categorie implements Categorie {
  const factory _Categorie({required final int id, required final String nom}) =
      _$CategorieImpl;

  factory _Categorie.fromJson(Map<String, dynamic> json) =
      _$CategorieImpl.fromJson;

  @override
  int get id;
  @override
  String get nom;

  /// Create a copy of Categorie
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategorieImplCopyWith<_$CategorieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
