// [lib/data/model/common_models.dart] (새 파일)

import 'package:json_annotation/json_annotation.dart';

part 'common_models.g.dart';

// 1. CreatorModel을 이 파일로 이동
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