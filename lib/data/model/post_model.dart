import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart'; // 코드 생성을 위한 부분

@JsonSerializable()
class PostModel {
  final int id;
  final String title;
  final String content;
  
  @JsonKey(name: 'createdAt') // JSON 키 'createdAt'을 'createdAt' 필드에 매핑
  final String createdAt;
  
  @JsonKey(name: 'updatedAt')
  final String updatedAt;
  
  // 'author' 필드는 API 명세서의 /boards/{boardId}/posts 응답에 없습니다.
  // final String author; 

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}