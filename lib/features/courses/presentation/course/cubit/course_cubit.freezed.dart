// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CourseState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<CourseModel> models) successAll,
    required TResult Function(CourseModel model) add,
    required TResult Function(CourseModel model) update,
    required TResult Function(ApiErrorHandler error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<CourseModel> models)? successAll,
    TResult? Function(CourseModel model)? add,
    TResult? Function(CourseModel model)? update,
    TResult? Function(ApiErrorHandler error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<CourseModel> models)? successAll,
    TResult Function(CourseModel model)? add,
    TResult Function(CourseModel model)? update,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CoursesLoading value) load,
    required TResult Function(AllCourses value) successAll,
    required TResult Function(AddCourses value) add,
    required TResult Function(UpdateCourses value) update,
    required TResult Function(CoursesError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CoursesLoading value)? load,
    TResult? Function(AllCourses value)? successAll,
    TResult? Function(AddCourses value)? add,
    TResult? Function(UpdateCourses value)? update,
    TResult? Function(CoursesError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CoursesLoading value)? load,
    TResult Function(AllCourses value)? successAll,
    TResult Function(AddCourses value)? add,
    TResult Function(UpdateCourses value)? update,
    TResult Function(CoursesError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseStateCopyWith<$Res> {
  factory $CourseStateCopyWith(
          CourseState value, $Res Function(CourseState) then) =
      _$CourseStateCopyWithImpl<$Res, CourseState>;
}

/// @nodoc
class _$CourseStateCopyWithImpl<$Res, $Val extends CourseState>
    implements $CourseStateCopyWith<$Res> {
  _$CourseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseState
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
    extends _$CourseStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CourseState.initial()';
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
    required TResult Function(List<CourseModel> models) successAll,
    required TResult Function(CourseModel model) add,
    required TResult Function(CourseModel model) update,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<CourseModel> models)? successAll,
    TResult? Function(CourseModel model)? add,
    TResult? Function(CourseModel model)? update,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<CourseModel> models)? successAll,
    TResult Function(CourseModel model)? add,
    TResult Function(CourseModel model)? update,
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
    required TResult Function(CoursesLoading value) load,
    required TResult Function(AllCourses value) successAll,
    required TResult Function(AddCourses value) add,
    required TResult Function(UpdateCourses value) update,
    required TResult Function(CoursesError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CoursesLoading value)? load,
    TResult? Function(AllCourses value)? successAll,
    TResult? Function(AddCourses value)? add,
    TResult? Function(UpdateCourses value)? update,
    TResult? Function(CoursesError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CoursesLoading value)? load,
    TResult Function(AllCourses value)? successAll,
    TResult Function(AddCourses value)? add,
    TResult Function(UpdateCourses value)? update,
    TResult Function(CoursesError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CourseState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$CoursesLoadingImplCopyWith<$Res> {
  factory _$$CoursesLoadingImplCopyWith(_$CoursesLoadingImpl value,
          $Res Function(_$CoursesLoadingImpl) then) =
      __$$CoursesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CoursesLoadingImplCopyWithImpl<$Res>
    extends _$CourseStateCopyWithImpl<$Res, _$CoursesLoadingImpl>
    implements _$$CoursesLoadingImplCopyWith<$Res> {
  __$$CoursesLoadingImplCopyWithImpl(
      _$CoursesLoadingImpl _value, $Res Function(_$CoursesLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CoursesLoadingImpl implements CoursesLoading {
  const _$CoursesLoadingImpl();

  @override
  String toString() {
    return 'CourseState.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CoursesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<CourseModel> models) successAll,
    required TResult Function(CourseModel model) add,
    required TResult Function(CourseModel model) update,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<CourseModel> models)? successAll,
    TResult? Function(CourseModel model)? add,
    TResult? Function(CourseModel model)? update,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<CourseModel> models)? successAll,
    TResult Function(CourseModel model)? add,
    TResult Function(CourseModel model)? update,
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
    required TResult Function(CoursesLoading value) load,
    required TResult Function(AllCourses value) successAll,
    required TResult Function(AddCourses value) add,
    required TResult Function(UpdateCourses value) update,
    required TResult Function(CoursesError value) error,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CoursesLoading value)? load,
    TResult? Function(AllCourses value)? successAll,
    TResult? Function(AddCourses value)? add,
    TResult? Function(UpdateCourses value)? update,
    TResult? Function(CoursesError value)? error,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CoursesLoading value)? load,
    TResult Function(AllCourses value)? successAll,
    TResult Function(AddCourses value)? add,
    TResult Function(UpdateCourses value)? update,
    TResult Function(CoursesError value)? error,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class CoursesLoading implements CourseState {
  const factory CoursesLoading() = _$CoursesLoadingImpl;
}

/// @nodoc
abstract class _$$AllCoursesImplCopyWith<$Res> {
  factory _$$AllCoursesImplCopyWith(
          _$AllCoursesImpl value, $Res Function(_$AllCoursesImpl) then) =
      __$$AllCoursesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CourseModel> models});
}

/// @nodoc
class __$$AllCoursesImplCopyWithImpl<$Res>
    extends _$CourseStateCopyWithImpl<$Res, _$AllCoursesImpl>
    implements _$$AllCoursesImplCopyWith<$Res> {
  __$$AllCoursesImplCopyWithImpl(
      _$AllCoursesImpl _value, $Res Function(_$AllCoursesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? models = null,
  }) {
    return _then(_$AllCoursesImpl(
      null == models
          ? _value._models
          : models // ignore: cast_nullable_to_non_nullable
              as List<CourseModel>,
    ));
  }
}

/// @nodoc

class _$AllCoursesImpl implements AllCourses {
  const _$AllCoursesImpl(final List<CourseModel> models) : _models = models;

  final List<CourseModel> _models;
  @override
  List<CourseModel> get models {
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_models);
  }

  @override
  String toString() {
    return 'CourseState.successAll(models: $models)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllCoursesImpl &&
            const DeepCollectionEquality().equals(other._models, _models));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_models));

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllCoursesImplCopyWith<_$AllCoursesImpl> get copyWith =>
      __$$AllCoursesImplCopyWithImpl<_$AllCoursesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<CourseModel> models) successAll,
    required TResult Function(CourseModel model) add,
    required TResult Function(CourseModel model) update,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return successAll(models);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<CourseModel> models)? successAll,
    TResult? Function(CourseModel model)? add,
    TResult? Function(CourseModel model)? update,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return successAll?.call(models);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<CourseModel> models)? successAll,
    TResult Function(CourseModel model)? add,
    TResult Function(CourseModel model)? update,
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
    required TResult Function(CoursesLoading value) load,
    required TResult Function(AllCourses value) successAll,
    required TResult Function(AddCourses value) add,
    required TResult Function(UpdateCourses value) update,
    required TResult Function(CoursesError value) error,
  }) {
    return successAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CoursesLoading value)? load,
    TResult? Function(AllCourses value)? successAll,
    TResult? Function(AddCourses value)? add,
    TResult? Function(UpdateCourses value)? update,
    TResult? Function(CoursesError value)? error,
  }) {
    return successAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CoursesLoading value)? load,
    TResult Function(AllCourses value)? successAll,
    TResult Function(AddCourses value)? add,
    TResult Function(UpdateCourses value)? update,
    TResult Function(CoursesError value)? error,
    required TResult orElse(),
  }) {
    if (successAll != null) {
      return successAll(this);
    }
    return orElse();
  }
}

abstract class AllCourses implements CourseState {
  const factory AllCourses(final List<CourseModel> models) = _$AllCoursesImpl;

  List<CourseModel> get models;

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllCoursesImplCopyWith<_$AllCoursesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCoursesImplCopyWith<$Res> {
  factory _$$AddCoursesImplCopyWith(
          _$AddCoursesImpl value, $Res Function(_$AddCoursesImpl) then) =
      __$$AddCoursesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CourseModel model});
}

/// @nodoc
class __$$AddCoursesImplCopyWithImpl<$Res>
    extends _$CourseStateCopyWithImpl<$Res, _$AddCoursesImpl>
    implements _$$AddCoursesImplCopyWith<$Res> {
  __$$AddCoursesImplCopyWithImpl(
      _$AddCoursesImpl _value, $Res Function(_$AddCoursesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_$AddCoursesImpl(
      null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as CourseModel,
    ));
  }
}

/// @nodoc

class _$AddCoursesImpl implements AddCourses {
  const _$AddCoursesImpl(this.model);

  @override
  final CourseModel model;

  @override
  String toString() {
    return 'CourseState.add(model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCoursesImpl &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, model);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCoursesImplCopyWith<_$AddCoursesImpl> get copyWith =>
      __$$AddCoursesImplCopyWithImpl<_$AddCoursesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<CourseModel> models) successAll,
    required TResult Function(CourseModel model) add,
    required TResult Function(CourseModel model) update,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return add(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<CourseModel> models)? successAll,
    TResult? Function(CourseModel model)? add,
    TResult? Function(CourseModel model)? update,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return add?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<CourseModel> models)? successAll,
    TResult Function(CourseModel model)? add,
    TResult Function(CourseModel model)? update,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CoursesLoading value) load,
    required TResult Function(AllCourses value) successAll,
    required TResult Function(AddCourses value) add,
    required TResult Function(UpdateCourses value) update,
    required TResult Function(CoursesError value) error,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CoursesLoading value)? load,
    TResult? Function(AllCourses value)? successAll,
    TResult? Function(AddCourses value)? add,
    TResult? Function(UpdateCourses value)? update,
    TResult? Function(CoursesError value)? error,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CoursesLoading value)? load,
    TResult Function(AllCourses value)? successAll,
    TResult Function(AddCourses value)? add,
    TResult Function(UpdateCourses value)? update,
    TResult Function(CoursesError value)? error,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class AddCourses implements CourseState {
  const factory AddCourses(final CourseModel model) = _$AddCoursesImpl;

  CourseModel get model;

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddCoursesImplCopyWith<_$AddCoursesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCoursesImplCopyWith<$Res> {
  factory _$$UpdateCoursesImplCopyWith(
          _$UpdateCoursesImpl value, $Res Function(_$UpdateCoursesImpl) then) =
      __$$UpdateCoursesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CourseModel model});
}

/// @nodoc
class __$$UpdateCoursesImplCopyWithImpl<$Res>
    extends _$CourseStateCopyWithImpl<$Res, _$UpdateCoursesImpl>
    implements _$$UpdateCoursesImplCopyWith<$Res> {
  __$$UpdateCoursesImplCopyWithImpl(
      _$UpdateCoursesImpl _value, $Res Function(_$UpdateCoursesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
  }) {
    return _then(_$UpdateCoursesImpl(
      null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as CourseModel,
    ));
  }
}

/// @nodoc

class _$UpdateCoursesImpl implements UpdateCourses {
  const _$UpdateCoursesImpl(this.model);

  @override
  final CourseModel model;

  @override
  String toString() {
    return 'CourseState.update(model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCoursesImpl &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, model);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCoursesImplCopyWith<_$UpdateCoursesImpl> get copyWith =>
      __$$UpdateCoursesImplCopyWithImpl<_$UpdateCoursesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<CourseModel> models) successAll,
    required TResult Function(CourseModel model) add,
    required TResult Function(CourseModel model) update,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return update(model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<CourseModel> models)? successAll,
    TResult? Function(CourseModel model)? add,
    TResult? Function(CourseModel model)? update,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return update?.call(model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<CourseModel> models)? successAll,
    TResult Function(CourseModel model)? add,
    TResult Function(CourseModel model)? update,
    TResult Function(ApiErrorHandler error)? error,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(model);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CoursesLoading value) load,
    required TResult Function(AllCourses value) successAll,
    required TResult Function(AddCourses value) add,
    required TResult Function(UpdateCourses value) update,
    required TResult Function(CoursesError value) error,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CoursesLoading value)? load,
    TResult? Function(AllCourses value)? successAll,
    TResult? Function(AddCourses value)? add,
    TResult? Function(UpdateCourses value)? update,
    TResult? Function(CoursesError value)? error,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CoursesLoading value)? load,
    TResult Function(AllCourses value)? successAll,
    TResult Function(AddCourses value)? add,
    TResult Function(UpdateCourses value)? update,
    TResult Function(CoursesError value)? error,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class UpdateCourses implements CourseState {
  const factory UpdateCourses(final CourseModel model) = _$UpdateCoursesImpl;

  CourseModel get model;

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCoursesImplCopyWith<_$UpdateCoursesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CoursesErrorImplCopyWith<$Res> {
  factory _$$CoursesErrorImplCopyWith(
          _$CoursesErrorImpl value, $Res Function(_$CoursesErrorImpl) then) =
      __$$CoursesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorHandler error});
}

/// @nodoc
class __$$CoursesErrorImplCopyWithImpl<$Res>
    extends _$CourseStateCopyWithImpl<$Res, _$CoursesErrorImpl>
    implements _$$CoursesErrorImplCopyWith<$Res> {
  __$$CoursesErrorImplCopyWithImpl(
      _$CoursesErrorImpl _value, $Res Function(_$CoursesErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$CoursesErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiErrorHandler,
    ));
  }
}

/// @nodoc

class _$CoursesErrorImpl implements CoursesError {
  const _$CoursesErrorImpl(this.error);

  @override
  final ApiErrorHandler error;

  @override
  String toString() {
    return 'CourseState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursesErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursesErrorImplCopyWith<_$CoursesErrorImpl> get copyWith =>
      __$$CoursesErrorImplCopyWithImpl<_$CoursesErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() load,
    required TResult Function(List<CourseModel> models) successAll,
    required TResult Function(CourseModel model) add,
    required TResult Function(CourseModel model) update,
    required TResult Function(ApiErrorHandler error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? load,
    TResult? Function(List<CourseModel> models)? successAll,
    TResult? Function(CourseModel model)? add,
    TResult? Function(CourseModel model)? update,
    TResult? Function(ApiErrorHandler error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? load,
    TResult Function(List<CourseModel> models)? successAll,
    TResult Function(CourseModel model)? add,
    TResult Function(CourseModel model)? update,
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
    required TResult Function(CoursesLoading value) load,
    required TResult Function(AllCourses value) successAll,
    required TResult Function(AddCourses value) add,
    required TResult Function(UpdateCourses value) update,
    required TResult Function(CoursesError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CoursesLoading value)? load,
    TResult? Function(AllCourses value)? successAll,
    TResult? Function(AddCourses value)? add,
    TResult? Function(UpdateCourses value)? update,
    TResult? Function(CoursesError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CoursesLoading value)? load,
    TResult Function(AllCourses value)? successAll,
    TResult Function(AddCourses value)? add,
    TResult Function(UpdateCourses value)? update,
    TResult Function(CoursesError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CoursesError implements CourseState {
  const factory CoursesError(final ApiErrorHandler error) = _$CoursesErrorImpl;

  ApiErrorHandler get error;

  /// Create a copy of CourseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursesErrorImplCopyWith<_$CoursesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
