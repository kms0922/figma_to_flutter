// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => BoardModel(
      id: json['id'] as String,
      title: json['title'] as String,
      creator: CreatorModel.fromJson(json['creator'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$BoardModelToJson(BoardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'creator': instance.creator,
      'createdAt': instance.createdAt,
    };

BoardListResponseModel _$BoardListResponseModelFromJson(
        Map<String, dynamic> json) =>
    BoardListResponseModel(
      count: (json['count'] as num).toInt(),
      data: (json['list'] as List<dynamic>)
          .map((e) => BoardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoardListResponseModelToJson(
        BoardListResponseModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'list': instance.data,
    };
