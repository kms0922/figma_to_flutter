// [lib/data/data_source/remote/post_api.dart]

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:figma_to_flutter/data/model/post_models.dart';

class PostApi {
  static const String _baseUrl = 'https://api.bulletin.newbies.gistory.me';

  // 1. [수정] 전체 게시글 목록 가져오기 (GET /posts)
  // boardId 파라미터 제거
  Future<List<PostModel>> getPosts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/posts'),
    );

    final contentType = response.headers['content-type'];
    if (response.statusCode != 200 ||
        contentType == null ||
        !contentType.contains('application/json')) {
      String bodySnippet =
          response.body.length > 200 ? '${response.body.substring(0, 200)}...' : response.body;
      throw Exception('오류: 서버가 JSON이 아닌 응답을 반환했습니다.\n'
          'Status Code: ${response.statusCode}\n'
          'Content-Type: $contentType\n'
          '응답 (일부): $bodySnippet');
    }

    try {
      String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);
      final PostListResponseModel postList =
          PostListResponseModel.fromJson(jsonData);
      return postList.data;
    } catch (e) {
      throw Exception('JSON 파싱 오류: $e \n응답: ${utf8.decode(response.bodyBytes)}');
    }
  }

  // 2. 게시글 상세 가져오기 (GET /posts/{id})
  // (기존 유지)
  Future<PostModel> getPostDetail(String postId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/posts/$postId'),
    );

    final contentType = response.headers['content-type'];
    if (response.statusCode != 200 ||
        contentType == null ||
        !contentType.contains('application/json')) {
      String bodySnippet =
          response.body.length > 200 ? '${response.body.substring(0, 200)}...' : response.body;
      throw Exception('오류: 서버가 JSON이 아닌 응답을 반환했습니다.\n'
          'Status Code: ${response.statusCode}\n'
          'Content-Type: $contentType\n'
          '응답 (일부): $bodySnippet');
    }

    try {
      String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return PostModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('JSON 파싱 오류: $e \n응답: ${utf8.decode(response.bodyBytes)}');
    }
  }

  // 3. [수정] 게시글 생성하기 (POST /posts)
  // boardId 파라미터 제거
  Future<PostModel> createPost(String title, String body, List<String> tags) async {
    
    final requestBody = CreatePostRequestModel(
      title: title,
      body: body,
      tags: tags,
    );

    final response = await http.post(
      Uri.parse('$_baseUrl/posts'), // 경로 수정 (/boards/{id}/posts -> /posts)
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody.toJson()),
    );

    final contentType = response.headers['content-type'];
    if (response.statusCode != 201 ||
        contentType == null ||
        !contentType.contains('application/json')) {
      String bodySnippet =
          response.body.length > 200 ? '${response.body.substring(0, 200)}...' : response.body;
      throw Exception('오류: 서버가 JSON이 아닌 응답을 반환했습니다.\n'
          'Status Code: ${response.statusCode}\n'
          'Content-Type: $contentType\n'
          '응답 (일부): $bodySnippet');
    }

    try {
      String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);
      return PostModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('JSON 파싱 오류: $e \n응답: ${utf8.decode(response.bodyBytes)}');
    }
  }
}