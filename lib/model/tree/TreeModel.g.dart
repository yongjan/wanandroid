// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TreeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeModel _$TreeModelFromJson(Map<String, dynamic> json) {
  return TreeModel(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : TreeRootModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$TreeModelToJson(TreeModel instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
