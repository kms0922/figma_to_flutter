// [lib/data/model/board_list_response_model.dart]

import 'package:figma_to_flutter/data/model/board_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'board_list_response_model.g.dart';

@JsonSerializable()
class BoardListResponseModel {
  final int count;
  
  // ‼️ JSON 'list' 키를 'data' 필드에 매핑합니다.
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