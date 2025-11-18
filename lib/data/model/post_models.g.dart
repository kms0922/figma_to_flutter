// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostRequestModel _$CreatePostRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreatePostRequestModel(
      title: json['title'] as String,
      body: json['body'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreatePostRequestModelToJson(
        CreatePostRequestModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'tags': instance.tags,
    };

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

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      image: json['image'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'id': instance.id,
    };

BoardModel_Post _$BoardModel_PostFromJson(Map<String, dynamic> json) =>
    BoardModel_Post(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: json['createdAt'] as String,
      creator: CreatorModel.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoardModel_PostToJson(BoardModel_Post instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt,
      'creator': instance.creator,
    };

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      board: BoardModel_Post.fromJson(json['board'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      createdBy:
          CreatorModel.fromJson(json['createdBy'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'tags': instance.tags,
      'board': instance.board,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'images': instance.images,
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
