// [lib/data/data_source/remote/post_api.dart]

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:figma_to_flutter/data/model/post_models.dart';

class PostApi {
  static const String _baseUrl = 'https://api.bulletin.newbies.gistory.me';

  // 1. 게시글 목록 가져오기 (GET /boards/{boardId}/posts)
  Future<List<PostModel>> getPosts(String boardId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/boards/$boardId/posts'),
    );

    // 공통 오류 처리
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

  // 2. 게시글 상세 가져오기 (GET /posts/{id} - 새로 추가)
  // (API 명세에 없었지만 상세 화면 구현을 위해 경로를 /posts/{id}로 추정)
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
      // 단일 PostModel로 파싱
      return PostModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('JSON 파싱 오류: $e \n응답: ${utf8.decode(response.bodyBytes)}');
    }
  }

  // 3. 게시글 생성하기 (POST /boards/{boardId}/posts - 수정)
  Future<PostModel> createPost(
      String boardId, String title, String body, List<String> tags) async {
    
    // 4. API 명세에 맞는 요청 모델 생성
    final requestBody = CreatePostRequestModel(
      title: title,
      body: body,
      tags: tags,
    );

    final response = await http.post(
      // 5. boardId를 URL 경로에 포함
      Uri.parse('$_baseUrl/boards/$boardId/posts'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // 6. API 명세에 맞는 body 전송 (CreatePostRequestModel 사용)
      body: jsonEncode(requestBody.toJson()),
    );

    final contentType = response.headers['content-type'];
    // 7. 생성 성공은 201(Created)
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
      // 8. 응답으로 생성된 PostModel 객체 파싱
      return PostModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('JSON 파싱 오류: $e \n응답: ${utf8.decode(response.bodyBytes)}');
    }
  }
}