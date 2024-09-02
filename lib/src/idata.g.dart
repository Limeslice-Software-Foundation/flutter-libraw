// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IDataImpl _$$IDataImplFromJson(Map<String, dynamic> json) => _$IDataImpl(
      make: json['make'] as String,
      model: json['model'] as String,
      normalizedMake: json['normalizedMake'] as String,
      normalizedModel: json['normalizedModel'] as String,
      makerIndex: (json['makerIndex'] as num).toInt(),
      software: json['software'] as String,
      rawCount: (json['rawCount'] as num).toInt(),
      isFoveon: (json['isFoveon'] as num).toInt(),
      dngVersion: (json['dngVersion'] as num).toInt(),
      colors: (json['colors'] as num).toInt(),
      filters: (json['filters'] as num).toInt(),
      cdesc: json['cdesc'] as String,
    );

Map<String, dynamic> _$$IDataImplToJson(_$IDataImpl instance) =>
    <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'normalizedMake': instance.normalizedMake,
      'normalizedModel': instance.normalizedModel,
      'makerIndex': instance.makerIndex,
      'software': instance.software,
      'rawCount': instance.rawCount,
      'isFoveon': instance.isFoveon,
      'dngVersion': instance.dngVersion,
      'colors': instance.colors,
      'filters': instance.filters,
      'cdesc': instance.cdesc,
    };
