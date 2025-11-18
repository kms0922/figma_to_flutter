// [lib/data/model/post_models.dart]

import 'package:json_annotation/json_annotation.dart';

part 'post_models.g.dart'; // build_runner가 생성할 파일

// 1. POST /posts 요청 Body를 위한 모델 (새로 추가)
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

// --- 이하 기존 모델 (수정 없음) ---

// 2. CreatorModel (API의 'createdBy' 객체용)
@JsonSerializable()
class CreatorModel {
  final String id;
  final String email;
  final String nickname;
  @JsonKey(name: 'createdAt')
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

// 3. ImageModel (API의 'images' 리스트 항목용)
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

// 4. BoardModel_Post (API의 'board' 객체용)
// (BoardModel과 충돌을 피하기 위해 이름을 유지)
@JsonSerializable()
class BoardModel_Post {
  final String id;
  final String title;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  final CreatorModel creator;

  BoardModel_Post({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.creator,
  });

  factory BoardModel_Post.fromJson(Map<String, dynamic> json) =>
      _$BoardModel_PostFromJson(json);

  Map<String, dynamic> toJson() => _$BoardModel_PostToJson(this);
}

// 5. PostModel (API의 'list' 리스트 항목용)
@JsonSerializable()
class PostModel {
  final String id;
  final String title;
  final String body;
  final List<String> tags;
  final BoardModel_Post board;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  final CreatorModel createdBy;
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

// 6. PostListResponseModel (GET /posts 응답 본문 전체)
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