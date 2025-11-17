// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostListResponseModel _$PostListResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostListResponseModel(
      count: (json['count'] as num).toInt(),
      data: (json['list'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostListResponseModelToJson(
        PostListResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'list': instance.data,
    };
