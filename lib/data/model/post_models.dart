// [lib/data/model/post_models.dart]

import 'package:json_annotation/json_annotation.dart';

part 'post_models.g.dart'; // build_runner가 생성할 파일

// 1. CreatorModel (먼저 정의)
@JsonSerializable()
class CreatorModel {
  final String id;
  final String email;
  final String nickname;
  final String createdAt;

  CreatorModel({
    required this.id,
    required this.email,
    required this.nickname,
    required this.createdAt,
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorModelToJson(this);
}

// 2. PostModel (CreatorModel을 사용)
@JsonSerializable()
class PostModel {
  final String id; // int -> String
  final String title;
  final String content;

  @JsonKey(name: 'createdAt')
  final String createdAt;
  
  final CreatorModel creator;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.creator,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

// 3. PostListResponseModel (PostModel을 사용)
@JsonSerializable()
class PostListResponseModel {
  final int count;
  
  @JsonKey(name: 'list') // 'data' -> 'list'
  final List<PostModel> data;

  PostListResponseModel({
    required this.count,
    required this.data,
  });

  factory PostListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostListResponseModelToJson(this);
}