// [lib/data/model/board_models.dart]

import 'package:json_annotation/json_annotation.dart';
// 1. CreatorModel을 가져오기 위해 post_models.dart를 import
import 'package:figma_to_flutter/data/model/post_models.dart';

part 'board_models.g.dart';

// 2. BoardModel (API 응답과 일치시킴)
@JsonSerializable()
class BoardModel {
  final String id;
  
  // 'name' 대신 'title'을 사용
  final String title; 
  
  // 'description'과 'updatedAt' 대신 'creator' 객체를 사용
  final CreatorModel creator;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  BoardModel({
    required this.id,
    required this.title,
    required this.creator,
    required this.createdAt,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardModelToJson(this);
}

// 3. BoardListResponseModel (이 부분은 동일)
@JsonSerializable()
class BoardListResponseModel {
  final int count;
  
  @JsonKey(name: 'list')
  final List<BoardModel> data;

  BoardListResponseModel({
    required this.count,
    required this.data,
  });

  factory BoardListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BoardListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardListResponseModelToJson(this);
}