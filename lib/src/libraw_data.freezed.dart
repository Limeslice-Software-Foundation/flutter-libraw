// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'libraw_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LibRawData _$LibRawDataFromJson(Map<String, dynamic> json) {
  return _LibRawData.fromJson(json);
}

/// @nodoc
mixin _$LibRawData {
  IData get idata => throw _privateConstructorUsedError;

  /// Serializes this LibRawData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LibRawData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LibRawDataCopyWith<LibRawData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LibRawDataCopyWith<$Res> {
  factory $LibRawDataCopyWith(
          LibRawData value, $Res Function(LibRawData) then) =
      _$LibRawDataCopyWithImpl<$Res, LibRawData>;
  @useResult
  $Res call({IData idata});

  $IDataCopyWith<$Res> get idata;
}

/// @nodoc
class _$LibRawDataCopyWithImpl<$Res, $Val extends LibRawData>
    implements $LibRawDataCopyWith<$Res> {
  _$LibRawDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LibRawData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idata = null,
  }) {
    return _then(_value.copyWith(
      idata: null == idata
          ? _value.idata
          : idata // ignore: cast_nullable_to_non_nullable
              as IData,
    ) as $Val);
  }

  /// Create a copy of LibRawData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IDataCopyWith<$Res> get idata {
    return $IDataCopyWith<$Res>(_value.idata, (value) {
      return _then(_value.copyWith(idata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LibRawDataImplCopyWith<$Res>
    implements $LibRawDataCopyWith<$Res> {
  factory _$$LibRawDataImplCopyWith(
          _$LibRawDataImpl value, $Res Function(_$LibRawDataImpl) then) =
      __$$LibRawDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IData idata});

  @override
  $IDataCopyWith<$Res> get idata;
}

/// @nodoc
class __$$LibRawDataImplCopyWithImpl<$Res>
    extends _$LibRawDataCopyWithImpl<$Res, _$LibRawDataImpl>
    implements _$$LibRawDataImplCopyWith<$Res> {
  __$$LibRawDataImplCopyWithImpl(
      _$LibRawDataImpl _value, $Res Function(_$LibRawDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LibRawData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idata = null,
  }) {
    return _then(_$LibRawDataImpl(
      idata: null == idata
          ? _value.idata
          : idata // ignore: cast_nullable_to_non_nullable
              as IData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LibRawDataImpl implements _LibRawData {
  const _$LibRawDataImpl({required this.idata});

  factory _$LibRawDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LibRawDataImplFromJson(json);

  @override
  final IData idata;

  @override
  String toString() {
    return 'LibRawData(idata: $idata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LibRawDataImpl &&
            (identical(other.idata, idata) || other.idata == idata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idata);

  /// Create a copy of LibRawData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LibRawDataImplCopyWith<_$LibRawDataImpl> get copyWith =>
      __$$LibRawDataImplCopyWithImpl<_$LibRawDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LibRawDataImplToJson(
      this,
    );
  }
}

abstract class _LibRawData implements LibRawData {
  const factory _LibRawData({required final IData idata}) = _$LibRawDataImpl;

  factory _LibRawData.fromJson(Map<String, dynamic> json) =
      _$LibRawDataImpl.fromJson;

  @override
  IData get idata;

  /// Create a copy of LibRawData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LibRawDataImplCopyWith<_$LibRawDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
