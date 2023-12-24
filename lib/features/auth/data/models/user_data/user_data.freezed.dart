// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
mixin _$UserData {
  @HiveField(0)
  String? get token => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get uId => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get phone => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get image => throw _privateConstructorUsedError;
  @HiveField(5)
  bool? get inCall => throw _privateConstructorUsedError;
  @HiveField(6)
  Map<String, String>? get contacts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call(
      {@HiveField(0) String? token,
      @HiveField(1) String? name,
      @HiveField(2) String? uId,
      @HiveField(3) String? phone,
      @HiveField(4) String? image,
      @HiveField(5) bool? inCall,
      @HiveField(6) Map<String, String>? contacts});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? name = freezed,
    Object? uId = freezed,
    Object? phone = freezed,
    Object? image = freezed,
    Object? inCall = freezed,
    Object? contacts = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      inCall: freezed == inCall
          ? _value.inCall
          : inCall // ignore: cast_nullable_to_non_nullable
              as bool?,
      contacts: freezed == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataImplCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$$UserDataImplCopyWith(
          _$UserDataImpl value, $Res Function(_$UserDataImpl) then) =
      __$$UserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? token,
      @HiveField(1) String? name,
      @HiveField(2) String? uId,
      @HiveField(3) String? phone,
      @HiveField(4) String? image,
      @HiveField(5) bool? inCall,
      @HiveField(6) Map<String, String>? contacts});
}

/// @nodoc
class __$$UserDataImplCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$UserDataImpl>
    implements _$$UserDataImplCopyWith<$Res> {
  __$$UserDataImplCopyWithImpl(
      _$UserDataImpl _value, $Res Function(_$UserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? name = freezed,
    Object? uId = freezed,
    Object? phone = freezed,
    Object? image = freezed,
    Object? inCall = freezed,
    Object? contacts = freezed,
  }) {
    return _then(_$UserDataImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      uId: freezed == uId
          ? _value.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      inCall: freezed == inCall
          ? _value.inCall
          : inCall // ignore: cast_nullable_to_non_nullable
              as bool?,
      contacts: freezed == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataImpl implements _UserData {
  _$UserDataImpl(
      {@HiveField(0) this.token,
      @HiveField(1) this.name,
      @HiveField(2) this.uId,
      @HiveField(3) this.phone,
      @HiveField(4) this.image,
      @HiveField(5) this.inCall,
      @HiveField(6) final Map<String, String>? contacts})
      : _contacts = contacts;

  factory _$UserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataImplFromJson(json);

  @override
  @HiveField(0)
  final String? token;
  @override
  @HiveField(1)
  final String? name;
  @override
  @HiveField(2)
  final String? uId;
  @override
  @HiveField(3)
  final String? phone;
  @override
  @HiveField(4)
  final String? image;
  @override
  @HiveField(5)
  final bool? inCall;
  final Map<String, String>? _contacts;
  @override
  @HiveField(6)
  Map<String, String>? get contacts {
    final value = _contacts;
    if (value == null) return null;
    if (_contacts is EqualUnmodifiableMapView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UserData(token: $token, name: $name, uId: $uId, phone: $phone, image: $image, inCall: $inCall, contacts: $contacts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uId, uId) || other.uId == uId) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.inCall, inCall) || other.inCall == inCall) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, name, uId, phone, image,
      inCall, const DeepCollectionEquality().hash(_contacts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      __$$UserDataImplCopyWithImpl<_$UserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataImplToJson(
      this,
    );
  }
}

abstract class _UserData implements UserData {
  factory _UserData(
      {@HiveField(0) final String? token,
      @HiveField(1) final String? name,
      @HiveField(2) final String? uId,
      @HiveField(3) final String? phone,
      @HiveField(4) final String? image,
      @HiveField(5) final bool? inCall,
      @HiveField(6) final Map<String, String>? contacts}) = _$UserDataImpl;

  factory _UserData.fromJson(Map<String, dynamic> json) =
      _$UserDataImpl.fromJson;

  @override
  @HiveField(0)
  String? get token;
  @override
  @HiveField(1)
  String? get name;
  @override
  @HiveField(2)
  String? get uId;
  @override
  @HiveField(3)
  String? get phone;
  @override
  @HiveField(4)
  String? get image;
  @override
  @HiveField(5)
  bool? get inCall;
  @override
  @HiveField(6)
  Map<String, String>? get contacts;
  @override
  @JsonKey(ignore: true)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
