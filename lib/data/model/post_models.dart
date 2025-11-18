// [lib/data/model/post_models.dart] (수정)

import 'package:json_annotation/json_annotation.dart';
// 1. common_models.dart를 import
import 'package:figma_to_flutter/data/model/common_models.dart';

part 'post_models.g.dart';

// ... (CreatePostRequestModel은 동일하게 유지)
@JsonSerializable()
class CreatePostRequestModel {
  final String title;
  final String body;
  final List<String> tags;

  CreatePostRequestModel({
    required this.title,
    required this.body,
    required this.tags,
  });

  factory CreatePostRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostRequestModelToJson(this);
}

// 2. CreatorModel 정의 (여기서 제거)

// 3. ImageModel (기존과 동일)
@JsonSerializable()
class ImageModel {
  final String image;
  final String id;

  ImageModel({
    required this.image,
    required this.id,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

// 4. BoardModel_Post -> BoardReferenceModel로 이름 변경 (Linter 오류 수정)
@JsonSerializable()
class BoardReferenceModel {
  final String id;
  final String title;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  final CreatorModel creator; // common_models.dart에서 가져옴

  BoardReferenceModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.creator,
  });

  factory BoardReferenceModel.fromJson(Map<String, dynamic> json) =>
      _$BoardReferenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardReferenceModelToJson(this);
}

// 5. PostModel (수정)
@JsonSerializable()
class PostModel {
  final String id;
  final String title;
  final String body;
  final List<String> tags;
  // 5-1. BoardReferenceModel을 사용하도록 수정
  final BoardReferenceModel board;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  final CreatorModel createdBy; // common_models.dart에서 가져옴
  final List<ImageModel> images;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.board,
    required this.createdAt,
    required this.createdBy,
    required this.images,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

// 6. PostListResponseModel (기존과 동일)
@JsonSerializable()
class PostListResponseModel {
  final int count;
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