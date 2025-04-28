// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppStateData {
  Home? get selectedHome => throw _privateConstructorUsedError;

  /// Create a copy of AppStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateDataCopyWith<AppStateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateDataCopyWith<$Res> {
  factory $AppStateDataCopyWith(
    AppStateData value,
    $Res Function(AppStateData) then,
  ) = _$AppStateDataCopyWithImpl<$Res, AppStateData>;
  @useResult
  $Res call({Home? selectedHome});
}

/// @nodoc
class _$AppStateDataCopyWithImpl<$Res, $Val extends AppStateData>
    implements $AppStateDataCopyWith<$Res> {
  _$AppStateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedHome = freezed}) {
    return _then(
      _value.copyWith(
            selectedHome:
                freezed == selectedHome
                    ? _value.selectedHome
                    : selectedHome // ignore: cast_nullable_to_non_nullable
                        as Home?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppStateDataImplCopyWith<$Res>
    implements $AppStateDataCopyWith<$Res> {
  factory _$$AppStateDataImplCopyWith(
    _$AppStateDataImpl value,
    $Res Function(_$AppStateDataImpl) then,
  ) = __$$AppStateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Home? selectedHome});
}

/// @nodoc
class __$$AppStateDataImplCopyWithImpl<$Res>
    extends _$AppStateDataCopyWithImpl<$Res, _$AppStateDataImpl>
    implements _$$AppStateDataImplCopyWith<$Res> {
  __$$AppStateDataImplCopyWithImpl(
    _$AppStateDataImpl _value,
    $Res Function(_$AppStateDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedHome = freezed}) {
    return _then(
      _$AppStateDataImpl(
        selectedHome:
            freezed == selectedHome
                ? _value.selectedHome
                : selectedHome // ignore: cast_nullable_to_non_nullable
                    as Home?,
      ),
    );
  }
}

/// @nodoc

class _$AppStateDataImpl implements _AppStateData {
  const _$AppStateDataImpl({this.selectedHome});

  @override
  final Home? selectedHome;

  @override
  String toString() {
    return 'AppStateData(selectedHome: $selectedHome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateDataImpl &&
            (identical(other.selectedHome, selectedHome) ||
                other.selectedHome == selectedHome));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedHome);

  /// Create a copy of AppStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateDataImplCopyWith<_$AppStateDataImpl> get copyWith =>
      __$$AppStateDataImplCopyWithImpl<_$AppStateDataImpl>(this, _$identity);
}

abstract class _AppStateData implements AppStateData {
  const factory _AppStateData({final Home? selectedHome}) = _$AppStateDataImpl;

  @override
  Home? get selectedHome;

  /// Create a copy of AppStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateDataImplCopyWith<_$AppStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
