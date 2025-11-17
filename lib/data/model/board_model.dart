import 'package:json_annotation/json_annotation.dart';

part 'board_model.g.dart'; // 코드 생성을 위한 부분

@JsonSerializable()
class BoardModel {
  final int id;
  final String name;
  final String description;

  BoardModel({
    required this.id,
    required this.name,
    required this.description,
  });

  // JSON에서 BoardModel 인스턴스를 생성
  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  // BoardModel 인스턴스를 JSON으로 변환
  Map<String, dynamic> toJson() => _$BoardModelToJson(this);
}