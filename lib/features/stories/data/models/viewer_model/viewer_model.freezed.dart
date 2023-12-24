// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'viewer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ViewerModel _$ViewerModelFromJson(Map<String, dynamic> json) {
  return _ViewerModel.fromJson(json);
}

/// @nodoc
mixin _$ViewerModel {
  String? get id => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get dateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ViewerModelCopyWith<ViewerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewerModelCopyWith<$Res> {
  factory $ViewerModelCopyWith(
          ViewerModel value, $Res Function(ViewerModel) then) =
      _$ViewerModelCopyWithImpl<$Res, ViewerModel>;
  @useResult
  $Res call({String? id, String? phoneNumber, String? dateTime});
}

/// @nodoc
class _$ViewerModelCopyWithImpl<$Res, $Val extends ViewerModel>
    implements $ViewerModelCopyWith<$Res> {
  _$ViewerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? phoneNumber = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ViewerModelImplCopyWith<$Res>
    implements $ViewerModelCopyWith<$Res> {
  factory _$$ViewerModelImplCopyWith(
          _$ViewerModelImpl value, $Res Function(_$ViewerModelImpl) then) =
      __$$ViewerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? phoneNumber, String? dateTime});
}

/// @nodoc
class __$$ViewerModelImplCopyWithImpl<$Res>
    extends _$ViewerModelCopyWithImpl<$Res, _$ViewerModelImpl>
    implements _$$ViewerModelImplCopyWith<$Res> {
  __$$ViewerModelImplCopyWithImpl(
      _$ViewerModelImpl _value, $Res Function(_$ViewerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? phoneNumber = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_$ViewerModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ViewerModelImpl implements _ViewerModel {
  _$ViewerModelImpl({this.id, this.phoneNumber, this.dateTime});

  factory _$ViewerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViewerModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? phoneNumber;
  @override
  final String? dateTime;

  @override
  String toString() {
    return 'ViewerModel(id: $id, phoneNumber: $phoneNumber, dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, phoneNumber, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewerModelImplCopyWith<_$ViewerModelImpl> get copyWith =>
      __$$ViewerModelImplCopyWithImpl<_$ViewerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ViewerModelImplToJson(
      this,
    );
  }
}

abstract class _ViewerModel implements ViewerModel {
  factory _ViewerModel(
      {final String? id,
      final String? phoneNumber,
      final String? dateTime}) = _$ViewerModelImpl;

  factory _ViewerModel.fromJson(Map<String, dynamic> json) =
      _$ViewerModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get phoneNumber;
  @override
  String? get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$ViewerModelImplCopyWith<_$ViewerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
