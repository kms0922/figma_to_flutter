// [lib/data/model/post_list_response_model.dart]

import 'package:figma_to_flutter/data/model/post_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_list_response_model.g.dart';

@JsonSerializable()
class PostListResponseModel {
  final int count;

  // ‼️ JSON 'list' 키를 'data' 필드에 매핑합니다.
  @JsonKey(name: 'list')
  final List<PostModel> data;

  PostListResponseModel({
    required this.count,
    required this.data,
  });

  factory PostListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostListResponseModelToJson(this);
}