// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_story_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ContactStoryModel _$ContactStoryModelFromJson(Map<String, dynamic> json) {
  return _ContactStoryModel.fromJson(json);
}

/// @nodoc
mixin _$ContactStoryModel {
  UserData? get user => throw _privateConstructorUsedError;
  List<StoryModel>? get stories => throw _privateConstructorUsedError;
  StoryModel? get lastStoryModel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactStoryModelCopyWith<ContactStoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactStoryModelCopyWith<$Res> {
  factory $ContactStoryModelCopyWith(
          ContactStoryModel value, $Res Function(ContactStoryModel) then) =
      _$ContactStoryModelCopyWithImpl<$Res, ContactStoryModel>;
  @useResult
  $Res call(
      {UserData? user, List<StoryModel>? stories, StoryModel? lastStoryModel});

  $UserDataCopyWith<$Res>? get user;
  $StoryModelCopyWith<$Res>? get lastStoryModel;
}

/// @nodoc
class _$ContactStoryModelCopyWithImpl<$Res, $Val extends ContactStoryModel>
    implements $ContactStoryModelCopyWith<$Res> {
  _$ContactStoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? stories = freezed,
    Object? lastStoryModel = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData?,
      stories: freezed == stories
          ? _value.stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>?,
      lastStoryModel: freezed == lastStoryModel
          ? _value.lastStoryModel
          : lastStoryModel // ignore: cast_nullable_to_non_nullable
              as StoryModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserDataCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StoryModelCopyWith<$Res>? get lastStoryModel {
    if (_value.lastStoryModel == null) {
      return null;
    }

    return $StoryModelCopyWith<$Res>(_value.lastStoryModel!, (value) {
      return _then(_value.copyWith(lastStoryModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ContactStoryModelImplCopyWith<$Res>
    implements $ContactStoryModelCopyWith<$Res> {
  factory _$$ContactStoryModelImplCopyWith(_$ContactStoryModelImpl value,
          $Res Function(_$ContactStoryModelImpl) then) =
      __$$ContactStoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserData? user, List<StoryModel>? stories, StoryModel? lastStoryModel});

  @override
  $UserDataCopyWith<$Res>? get user;
  @override
  $StoryModelCopyWith<$Res>? get lastStoryModel;
}

/// @nodoc
class __$$ContactStoryModelImplCopyWithImpl<$Res>
    extends _$ContactStoryModelCopyWithImpl<$Res, _$ContactStoryModelImpl>
    implements _$$ContactStoryModelImplCopyWith<$Res> {
  __$$ContactStoryModelImplCopyWithImpl(_$ContactStoryModelImpl _value,
      $Res Function(_$ContactStoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? stories = freezed,
    Object? lastStoryModel = freezed,
  }) {
    return _then(_$ContactStoryModelImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData?,
      stories: freezed == stories
          ? _value._stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<StoryModel>?,
      lastStoryModel: freezed == lastStoryModel
          ? _value.lastStoryModel
          : lastStoryModel // ignore: cast_nullable_to_non_nullable
              as StoryModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactStoryModelImpl implements _ContactStoryModel {
  _$ContactStoryModelImpl(
      {this.user, final List<StoryModel>? stories, this.lastStoryModel})
      : _stories = stories;

  factory _$ContactStoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactStoryModelImplFromJson(json);

  @override
  final UserData? user;
  final List<StoryModel>? _stories;
  @override
  List<StoryModel>? get stories {
    final value = _stories;
    if (value == null) return null;
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final StoryModel? lastStoryModel;

  @override
  String toString() {
    return 'ContactStoryModel(user: $user, stories: $stories, lastStoryModel: $lastStoryModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactStoryModelImpl &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._stories, _stories) &&
            (identical(other.lastStoryModel, lastStoryModel) ||
                other.lastStoryModel == lastStoryModel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user,
      const DeepCollectionEquality().hash(_stories), lastStoryModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactStoryModelImplCopyWith<_$ContactStoryModelImpl> get copyWith =>
      __$$ContactStoryModelImplCopyWithImpl<_$ContactStoryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactStoryModelImplToJson(
      this,
    );
  }
}

abstract class _ContactStoryModel implements ContactStoryModel {
  factory _ContactStoryModel(
      {final UserData? user,
      final List<StoryModel>? stories,
      final StoryModel? lastStoryModel}) = _$ContactStoryModelImpl;

  factory _ContactStoryModel.fromJson(Map<String, dynamic> json) =
      _$ContactStoryModelImpl.fromJson;

  @override
  UserData? get user;
  @override
  List<StoryModel>? get stories;
  @override
  StoryModel? get lastStoryModel;
  @override
  @JsonKey(ignore: true)
  _$$ContactStoryModelImplCopyWith<_$ContactStoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
