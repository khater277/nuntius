// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_users_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllUsersModel _$AllUsersModelFromJson(Map<String, dynamic> json) {
  return _AllUsersModel.fromJson(json);
}

/// @nodoc
mixin _$AllUsersModel {
  @HiveField(0)
  List<UserData>? get users => throw _privateConstructorUsedError;

  /// Serializes this AllUsersModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllUsersModelCopyWith<AllUsersModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllUsersModelCopyWith<$Res> {
  factory $AllUsersModelCopyWith(
          AllUsersModel value, $Res Function(AllUsersModel) then) =
      _$AllUsersModelCopyWithImpl<$Res, AllUsersModel>;
  @useResult
  $Res call({@HiveField(0) List<UserData>? users});
}

/// @nodoc
class _$AllUsersModelCopyWithImpl<$Res, $Val extends AllUsersModel>
    implements $AllUsersModelCopyWith<$Res> {
  _$AllUsersModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = freezed,
  }) {
    return _then(_value.copyWith(
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllUsersModelImplCopyWith<$Res>
    implements $AllUsersModelCopyWith<$Res> {
  factory _$$AllUsersModelImplCopyWith(
          _$AllUsersModelImpl value, $Res Function(_$AllUsersModelImpl) then) =
      __$$AllUsersModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) List<UserData>? users});
}

/// @nodoc
class __$$AllUsersModelImplCopyWithImpl<$Res>
    extends _$AllUsersModelCopyWithImpl<$Res, _$AllUsersModelImpl>
    implements _$$AllUsersModelImplCopyWith<$Res> {
  __$$AllUsersModelImplCopyWithImpl(
      _$AllUsersModelImpl _value, $Res Function(_$AllUsersModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = freezed,
  }) {
    return _then(_$AllUsersModelImpl(
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserData>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllUsersModelImpl implements _AllUsersModel {
  _$AllUsersModelImpl({@HiveField(0) final List<UserData>? users})
      : _users = users;

  factory _$AllUsersModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllUsersModelImplFromJson(json);

  final List<UserData>? _users;
  @override
  @HiveField(0)
  List<UserData>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AllUsersModel(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllUsersModelImpl &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  /// Create a copy of AllUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllUsersModelImplCopyWith<_$AllUsersModelImpl> get copyWith =>
      __$$AllUsersModelImplCopyWithImpl<_$AllUsersModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllUsersModelImplToJson(
      this,
    );
  }
}

abstract class _AllUsersModel implements AllUsersModel {
  factory _AllUsersModel({@HiveField(0) final List<UserData>? users}) =
      _$AllUsersModelImpl;

  factory _AllUsersModel.fromJson(Map<String, dynamic> json) =
      _$AllUsersModelImpl.fromJson;

  @override
  @HiveField(0)
  List<UserData>? get users;

  /// Create a copy of AllUsersModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllUsersModelImplCopyWith<_$AllUsersModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
