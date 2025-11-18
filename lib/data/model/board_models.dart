// [lib/data/model/board_models.dart] (수정)

import 'package:json_annotation/json_annotation.dart';
// 1. import 경로를 'common_models.dart'로 변경
import 'package:figma_to_flutter/data/model/common_models.dart';

part 'board_models.g.dart';

// 2. BoardModel (CreatorModel을 common_models.dart에서 가져옴)
@JsonSerializable()
class BoardModel {
  final String id;
  final String title;
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

// 3. BoardListResponseModel (기존과 동일)
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