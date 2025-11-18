// [lib/data/data_source/remote/board_api.dart]

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:figma_to_flutter/data/model/board_models.dart'; 

class BoardApi {
  static const String _baseUrl = 'https://api.bulletin.newbies.gistory.me';

  Future<List<BoardModel>> getBoards() async {
    final response = await http.get(Uri.parse('$_baseUrl/boards'));

    // 3. 오류 방지 로직 (HTML/500/404 등)
    final contentType = response.headers['content-type'];
    if (response.statusCode != 200 || contentType == null || !contentType.contains('application/json')) {
      String bodySnippet = response.body.length > 200 ? '${response.body.substring(0, 200)}...' : response.body;
      throw Exception(
          '오류: 서버가 JSON이 아닌 응답을 반환했습니다.\n'
          'Status Code: ${response.statusCode}\n'
          'Content-Type: $contentType\n'
          '응답 (일부): $bodySnippet');
    }

    try {
      String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);
      
      // 4. 수정된 모델로 파싱
      final boardResponse = BoardListResponseModel.fromJson(jsonData);

      // 5. 실제 데이터인 data (List<BoardModel>)를 반환
      return boardResponse.data;
    } catch (e) {
      // 6. JSON 파싱 오류 (모델 불일치 등)
      throw Exception('JSON 파싱 오류: $e \n응답: ${utf8.decode(response.bodyBytes)}');
    }
  }

  // 1. POST /boards API 호출 함수 추가
  Future<BoardModel> createBoard(String title) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/boards'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // 2. API 명세에 맞게 {"title": "..."} 형식으로 body 전송
      body: jsonEncode({
        "title": title,
      }),
    );

    // 3. 오류 방지 로직 (POST)
    final contentType = response.headers['content-type'];
    if (response.statusCode != 201 || contentType == null || !contentType.contains('application/json')) {
      String bodySnippet = response.body.length > 200 ? '${response.body.substring(0, 200)}...' : response.body;
      throw Exception(
          '오류: 서버가 JSON이 아닌 응답을 반환했습니다.\n'
          'Status Code: ${response.statusCode}\n'
          'Content-Type: $contentType\n'
          '응답 (일부): $bodySnippet');
    }

    try {
      String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);
      
      // 4. 단일 BoardModel.fromJson으로 파싱 (응답이 단일 객체일 경우)
      return BoardModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('JSON 파싱 오류: $e \n응답: ${utf8.decode(response.bodyBytes)}');
    }
  }
}