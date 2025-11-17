// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatorModel _$CreatorModelFromJson(Map<String, dynamic> json) => CreatorModel(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CreatorModelToJson(CreatorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'createdAt': instance.createdAt,
    };

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: json['createdAt'] as String,
      creator: CreatorModel.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'creator': instance.creator,
    };

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
