import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:figma_to_flutter/data/model/post_models.dart';

class PostApi {
  static const String _baseUrl = 'https://api.bulletin.newbies.gistory.me';

  // 1. 게시글 목록 조회
  Future<List<PostModel>> getPosts() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));

    if (response.statusCode != 200) {
      throw Exception('게시글 목록 로드 실패: ${response.statusCode}');
    }

    try {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      final postList = PostListResponseModel.fromJson(jsonData);
      return postList.data;
    } catch (e) {
      throw Exception('데이터 파싱 오류: $e');
    }
  }

  // 2. 게시글 상세 조회
  Future<PostModel> getPostDetail(String postId) async {
    final response = await http.get(Uri.parse('$_baseUrl/posts/$postId'));

    if (response.statusCode != 200) {
      throw Exception('게시글 상세 로드 실패: ${response.statusCode}');
    }

    try {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      return PostModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('데이터 파싱 오류: $e');
    }
  }

  // 3. 게시글 생성 (텍스트만)
  Future<PostModel> createPost(String title, String body, List<String> tags) async {
    final requestBody = CreatePostRequestModel(
      title: title,
      body: body,
      tags: tags,
    );

    final response = await http.post(
      Uri.parse('$_baseUrl/posts'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(requestBody.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('게시글 생성 실패: ${response.statusCode}');
    }

    try {
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      return PostModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('데이터 파싱 오류: $e');
    }
  }
}