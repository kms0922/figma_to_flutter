// [lib/data/model/board_models.dart]

import 'package:json_annotation/json_annotation.dart';

part 'board_models.g.dart'; // build_runner가 생성할 파일

// 1. BoardModel (API 응답과 일치시킴)
@JsonSerializable()
class BoardModel {
  final String id; // int -> String
  final String name;
  final String description;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  BoardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardModelToJson(this);
}

// 2. BoardListResponseModel (같은 파일에 통합)
@JsonSerializable()
class BoardListResponseModel {
  final int count;
  
  @JsonKey(name: 'list') // 'data' -> 'list'
  final List<BoardModel> data; // BoardModel 리스트를 가짐

  BoardListResponseModel({
    required this.count,
    required this.data,
  });

  factory BoardListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BoardListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardListResponseModelToJson(this);
}