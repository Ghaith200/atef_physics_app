// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<UserModel> models) successAll,
    required TResult Function(UserModel user) update,
    required TResult Function(UserModel model) remove,
    required TResult Function(ApiErrorHandler error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<UserModel> models)? successAll,
    TResult? Function(UserModel user)? update,
    TResult? Function(UserModel model)? remove,
    TResult? Function(ApiErrorHandler error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<UserModel> models)? successAll,
    TResult Function(UserModel user)? update,
    TResult Function(UserModel model)? remove,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(UserLoading value) load,
    required TResult Function(AllUser value) successAll,
    required TResult Function(usersUpdate value) update,
    required TResult Function(UserRemoved value) remove,
    required TResult Function(UserError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(UserLoading value)? load,
    TResult? Function(AllUser value)? successAll,
    TResult? Function(usersUpdate value)? update,
    TResult? Function(UserRemoved value)? remove,
    TResult? Function(UserError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(UserLoading value)? load,
    TResult Function(AllUser value)? successAll,
    TResult Function(usersUpdate value)? update,
    TResult Function(UserRemoved value)? remove,
    TResult Function(UserError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'UserState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<UserModel> models) successAll,
    required TResult Function(UserModel user) update,
    required TResult Function(UserModel model) remove,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<UserModel> models)? successAll,
    TResult? Function(UserModel user)? update,
    TResult? Function(UserModel model)? remove,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<UserModel> models)? successAll,
    TResult Function(UserModel user)? update,
    TResult Function(UserModel model)? remove,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(UserLoading value) load,
    required TResult Function(AllUser value) successAll,
    required TResult Function(usersUpdate value) update,
    required TResult Function(UserRemoved value) remove,
    required TResult Function(UserError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(UserLoading value)? load,
    TResult? Function(AllUser value)? successAll,
    TResult? Function(usersUpdate value)? update,
    TResult? Function(UserRemoved value)? remove,
    TResult? Function(UserError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(UserLoading value)? load,
    TResult Function(AllUser value)? successAll,
    TResult Function(usersUpdate value)? update,
    TResult Function(UserRemoved value)? remove,
    TResult Function(UserError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UserState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$UserLoadingImplCopyWith<$Res> {
  factory _$$UserLoadingImplCopyWith(
          _$UserLoadingImpl value, $Res Function(_$UserLoadingImpl) then) =
      __$$UserLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserLoadingImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserLoadingImpl>
    implements _$$UserLoadingImplCopyWith<$Res> {
  __$$UserLoadingImplCopyWithImpl(
      _$UserLoadingImpl _value, $Res Function(_$UserLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserLoadingImpl implements UserLoading {
  const _$UserLoadingImpl();

  @override
  String toString() {
    return 'UserState.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<UserModel> models) successAll,
    required TResult Function(UserModel user) update,
    required TResult Function(UserModel model) remove,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<UserModel> models)? successAll,
    TResult? Function(UserModel user)? update,
    TResult? Function(UserModel model)? remove,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<UserModel> models)? successAll,
    TResult Function(UserModel user)? update,
    TResult Function(UserModel model)? remove,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(UserLoading value) load,
    required TResult Function(AllUser value) successAll,
    required TResult Function(usersUpdate value) update,
    required TResult Function(UserRemoved value) remove,
    required TResult Function(UserError value) error,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(UserLoading value)? load,
    TResult? Function(AllUser value)? successAll,
    TResult? Function(usersUpdate value)? update,
    TResult? Function(UserRemoved value)? remove,
    TResult? Function(UserError value)? error,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(UserLoading value)? load,
    TResult Function(AllUser value)? successAll,
    TResult Function(usersUpdate value)? update,
    TResult Function(UserRemoved value)? remove,
    TResult Function(UserError value)? error,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class UserLoading implements UserState {
  const factory UserLoading() = _$UserLoadingImpl;
}

/// @nodoc
abstract class _$$AllUserImplCopyWith<$Res> {
  factory _$$AllUserImplCopyWith(
          _$AllUserImpl value, $Res Function(_$AllUserImpl) then) =
      __$$AllUserImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<UserModel> models});
}

/// @nodoc
class __$$AllUserImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$AllUserImpl>
    implements _$$AllUserImplCopyWith<$Res> {
  __$$AllUserImplCopyWithImpl(
      _$AllUserImpl _value, $Res Function(_$AllUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? models = null,
  }) {
    return _then(_$AllUserImpl(
      null == models
          ? _value._models
          : models // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc

class _$AllUserImpl implements AllUser {
  const _$AllUserImpl(final List<UserModel> models) : _models = models;

  final List<UserModel> _models;
  @override
  List<UserModel> get models {
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_models);
  }

  @override
  String toString() {
    return 'UserState.successAll(models: $models)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllUserImpl &&
            const DeepCollectionEquality().equals(other._models, _models));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_models));

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllUserImplCopyWith<_$AllUserImpl> get copyWith =>
      __$$AllUserImplCopyWithImpl<_$AllUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<UserModel> models) successAll,
    required TResult Function(UserModel user) update,
    required TResult Function(UserModel model) remove,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return successAll(models);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<UserModel> models)? successAll,
    TResult? Function(UserModel user)? update,
    TResult? Function(UserModel model)? remove,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return successAll?.call(models);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<UserModel> models)? successAll,
    TResult Function(UserModel user)? update,
    TResult Function(UserModel model)? remove,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) {
    if (successAll != null) {
      return successAll(models);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(UserLoading value) load,
    required TResult Function(AllUser value) successAll,
    required TResult Function(usersUpdate value) update,
    required TResult Function(UserRemoved value) remove,
    required TResult Function(UserError value) error,
  }) {
    return successAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(UserLoading value)? load,
    TResult? Function(AllUser value)? successAll,
    TResult? Function(usersUpdate value)? update,
    TResult? Function(UserRemoved value)? remove,
    TResult? Function(UserError value)? error,
  }) {
    return successAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(UserLoading value)? load,
    TResult Function(AllUser value)? successAll,
    TResult Function(usersUpdate value)? update,
    TResult Function(UserRemoved value)? remove,
    TResult Function(UserError value)? error,
    required TResult orElse(),
  }) {
    if (successAll != null) {
      return successAll(this);
    }
    return orElse();
  }
}

abstract class AllUser implements UserState {
  const factory AllUser(final List<UserModel> models) = _$AllUserImpl;

  List<UserModel> get models;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllUserImplCopyWith<_$AllUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$usersUpdateImplCopyWith<$Res> {
  factory _$$usersUpdateImplCopyWith(
          _$usersUpdateImpl value, $Res Function(_$usersUpdateImpl) then) =
      __$$usersUpdateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel user});
}

/// @nodoc
class __$$usersUpdateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$usersUpdateImpl>
    implements _$$usersUpdateImplCopyWith<$Res> {
  __$$usersUpdateImplCopyWithImpl(
      _$usersUpdateImpl _value, $Res Function(_$usersUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$usersUpdateImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$usersUpdateImpl implements usersUpdate {
  const _$usersUpdateImpl({required this.user});

  @override
  final UserModel user;

  @override
  String toString() {
    return 'UserState.update(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$usersUpdateImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$usersUpdateImplCopyWith<_$usersUpdateImpl> get copyWith =>
      __$$usersUpdateImplCopyWithImpl<_$usersUpdateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<UserModel> models) successAll,
    required TResult Function(UserModel user) update,
    required TResult Function(UserModel model) remove,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return update(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<UserModel> models)? successAll,
    TResult? Function(UserModel user)? update,
    TResult? Function(UserModel model)? remove,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return update?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<UserModel> models)? successAll,
    TResult Function(UserModel user)? update,
    TResult Function(UserModel model)? remove,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(UserLoading value) load,
    required TResult Function(AllUser value) successAll,
    required TResult Function(usersUpdate value) update,
    required TResult Function(UserRemoved value) remove,
    required TResult Function(UserError value) error,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(UserLoading value)? load,
    TResult? Function(AllUser value)? successAll,
    TResult? Function(usersUpdate value)? update,
    TResult? Function(UserRemoved value)? remove,
    TResult? Function(UserError value)? error,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(UserLoading value)? load,
    TResult Function(AllUser value)? successAll,
    TResult Function(usersUpdate value)? update,
    TResult Function(UserRemoved value)? remove,
    TResult Function(UserError value)? error,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class usersUpdate implements UserState {
  const factory usersUpdate({required final UserModel user}) =
      _$usersUpdateImpl;

  UserModel get user;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$usersUpdateImplCopyWith<_$usersUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserRemovedImplCopyWith<$Res> {
  factory _$$UserRemovedImplCopyWith(
          _$UserRemovedImpl value, $Res Function(_$UserRemovedImpl) then) =
      __$$UserRemovedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel model});
}

/// @nodoc
class __$$UserRemovedImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserRemovedImpl>
    implements _$$UserRemovedImplCopyWith<$Res> {
  __$$UserRemovedImplCopyWithImpl(
      _$UserRemovedImpl _value, $Res Function(_$UserRemovedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_$UserRemovedImpl(
      null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$UserRemovedImpl implements UserRemoved {
  const _$UserRemovedImpl(this.model);

  @override
  final UserModel model;

  @override
  String toString() {
    return 'UserState.remove(model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRemovedImpl &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, model);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRemovedImplCopyWith<_$UserRemovedImpl> get copyWith =>
      __$$UserRemovedImplCopyWithImpl<_$UserRemovedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<UserModel> models) successAll,
    required TResult Function(UserModel user) update,
    required TResult Function(UserModel model) remove,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return remove(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<UserModel> models)? successAll,
    TResult? Function(UserModel user)? update,
    TResult? Function(UserModel model)? remove,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return remove?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<UserModel> models)? successAll,
    TResult Function(UserModel user)? update,
    TResult Function(UserModel model)? remove,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(UserLoading value) load,
    required TResult Function(AllUser value) successAll,
    required TResult Function(usersUpdate value) update,
    required TResult Function(UserRemoved value) remove,
    required TResult Function(UserError value) error,
  }) {
    return remove(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(UserLoading value)? load,
    TResult? Function(AllUser value)? successAll,
    TResult? Function(usersUpdate value)? update,
    TResult? Function(UserRemoved value)? remove,
    TResult? Function(UserError value)? error,
  }) {
    return remove?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(UserLoading value)? load,
    TResult Function(AllUser value)? successAll,
    TResult Function(usersUpdate value)? update,
    TResult Function(UserRemoved value)? remove,
    TResult Function(UserError value)? error,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(this);
    }
    return orElse();
  }
}

abstract class UserRemoved implements UserState {
  const factory UserRemoved(final UserModel model) = _$UserRemovedImpl;

  UserModel get model;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRemovedImplCopyWith<_$UserRemovedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserErrorImplCopyWith<$Res> {
  factory _$$UserErrorImplCopyWith(
          _$UserErrorImpl value, $Res Function(_$UserErrorImpl) then) =
      __$$UserErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorHandler error});
}

/// @nodoc
class __$$UserErrorImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$UserErrorImpl>
    implements _$$UserErrorImplCopyWith<$Res> {
  __$$UserErrorImplCopyWithImpl(
      _$UserErrorImpl _value, $Res Function(_$UserErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$UserErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiErrorHandler,
    ));
  }
}

/// @nodoc

class _$UserErrorImpl implements UserError {
  const _$UserErrorImpl(this.error);

  @override
  final ApiErrorHandler error;

  @override
  String toString() {
    return 'UserState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserErrorImplCopyWith<_$UserErrorImpl> get copyWith =>
      __$$UserErrorImplCopyWithImpl<_$UserErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<UserModel> models) successAll,
    required TResult Function(UserModel user) update,
    required TResult Function(UserModel model) remove,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<UserModel> models)? successAll,
    TResult? Function(UserModel user)? update,
    TResult? Function(UserModel model)? remove,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<UserModel> models)? successAll,
    TResult Function(UserModel user)? update,
    TResult Function(UserModel model)? remove,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(UserLoading value) load,
    required TResult Function(AllUser value) successAll,
    required TResult Function(usersUpdate value) update,
    required TResult Function(UserRemoved value) remove,
    required TResult Function(UserError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(UserLoading value)? load,
    TResult? Function(AllUser value)? successAll,
    TResult? Function(usersUpdate value)? update,
    TResult? Function(UserRemoved value)? remove,
    TResult? Function(UserError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(UserLoading value)? load,
    TResult Function(AllUser value)? successAll,
    TResult Function(usersUpdate value)? update,
    TResult Function(UserRemoved value)? remove,
    TResult Function(UserError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UserError implements UserState {
  const factory UserError(final ApiErrorHandler error) = _$UserErrorImpl;

  ApiErrorHandler get error;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserErrorImplCopyWith<_$UserErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
