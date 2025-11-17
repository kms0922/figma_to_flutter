// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
