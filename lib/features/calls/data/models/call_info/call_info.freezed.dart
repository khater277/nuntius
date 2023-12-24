// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CallInfo _$CallInfoFromJson(Map<String, dynamic> json) {
  return _CallInfo.fromJson(json);
}

/// @nodoc
mixin _$CallInfo {
  CallModel? get callModel => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallInfoCopyWith<CallInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallInfoCopyWith<$Res> {
  factory $CallInfoCopyWith(CallInfo value, $Res Function(CallInfo) then) =
      _$CallInfoCopyWithImpl<$Res, CallInfo>;
  @useResult
  $Res call({CallModel? callModel, String? name, String? image});

  $CallModelCopyWith<$Res>? get callModel;
}

/// @nodoc
class _$CallInfoCopyWithImpl<$Res, $Val extends CallInfo>
    implements $CallInfoCopyWith<$Res> {
  _$CallInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callModel = freezed,
    Object? name = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      callModel: freezed == callModel
          ? _value.callModel
          : callModel // ignore: cast_nullable_to_non_nullable
              as CallModel?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CallModelCopyWith<$Res>? get callModel {
    if (_value.callModel == null) {
      return null;
    }

    return $CallModelCopyWith<$Res>(_value.callModel!, (value) {
      return _then(_value.copyWith(callModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallInfoImplCopyWith<$Res>
    implements $CallInfoCopyWith<$Res> {
  factory _$$CallInfoImplCopyWith(
          _$CallInfoImpl value, $Res Function(_$CallInfoImpl) then) =
      __$$CallInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CallModel? callModel, String? name, String? image});

  @override
  $CallModelCopyWith<$Res>? get callModel;
}

/// @nodoc
class __$$CallInfoImplCopyWithImpl<$Res>
    extends _$CallInfoCopyWithImpl<$Res, _$CallInfoImpl>
    implements _$$CallInfoImplCopyWith<$Res> {
  __$$CallInfoImplCopyWithImpl(
      _$CallInfoImpl _value, $Res Function(_$CallInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callModel = freezed,
    Object? name = freezed,
    Object? image = freezed,
  }) {
    return _then(_$CallInfoImpl(
      callModel: freezed == callModel
          ? _value.callModel
          : callModel // ignore: cast_nullable_to_non_nullable
              as CallModel?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallInfoImpl implements _CallInfo {
  _$CallInfoImpl({this.callModel, this.name, this.image});

  factory _$CallInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallInfoImplFromJson(json);

  @override
  final CallModel? callModel;
  @override
  final String? name;
  @override
  final String? image;

  @override
  String toString() {
    return 'CallInfo(callModel: $callModel, name: $name, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallInfoImpl &&
            (identical(other.callModel, callModel) ||
                other.callModel == callModel) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, callModel, name, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallInfoImplCopyWith<_$CallInfoImpl> get copyWith =>
      __$$CallInfoImplCopyWithImpl<_$CallInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallInfoImplToJson(
      this,
    );
  }
}

abstract class _CallInfo implements CallInfo {
  factory _CallInfo(
      {final CallModel? callModel,
      final String? name,
      final String? image}) = _$CallInfoImpl;

  factory _CallInfo.fromJson(Map<String, dynamic> json) =
      _$CallInfoImpl.fromJson;

  @override
  CallModel? get callModel;
  @override
  String? get name;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$CallInfoImplCopyWith<_$CallInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
