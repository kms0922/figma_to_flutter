// [lib/data/data_source/remote/board_api.dart]

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:figma_to_flutter/data/model/board_model.dart';

class BoardApi {
  // API의 기본 URL
  static const String _baseUrl = 'https://api.bulletin.newbies.gistory.me';

  // GET /boards - 모든 게시판 목록 가져오기
  Future<List<BoardModel>> getBoards() async {
    final response = await http.get(Uri.parse('$_baseUrl/boards'));

    // --- [오류 수정] ---
    // 1. Content-Type 헤더를 확인합니다.
    final contentType = response.headers['content-type'];

    // 2. 상태 코드가 200이 아니거나, Content-Type이 JSON이 아닐 경우
    //    HTML 내용을 포함하여 예외를 발생시킵니다.
    if (response.statusCode != 200 ||
        contentType == null ||
        !contentType.contains('application/json')) {
      
      // 응답 내용이 너무 길 수 있으므로 200자까지만 잘라서 보여줍니다.
      String bodySnippet = response.body.length > 200
          ? '${response.body.substring(0, 200)}...'
          : response.body;

      throw Exception(
          '오류: 서버가 JSON이 아닌 응답을 반환했습니다.\n'
          'Status Code: ${response.statusCode}\n'
          'Content-Type: $contentType\n'
          '응답 내용 (일부): $bodySnippet');
    }
    // --- [수정 끝] ---

    // 이제 이 코드는 응답이 JSON임을 보장할 때만 실행됩니다.
    try {
      String responseBody = utf8.decode(response.bodyBytes);
      final dynamic jsonData = jsonDecode(responseBody);

      if (jsonData is List) {
        List<dynamic> jsonList = jsonData;
        return jsonList.map((json) => BoardModel.fromJson(json)).toList();
      } else {
        // 서버가 200 OK와 application/json을 보냈지만 List가 아닌 경우
        throw Exception('오류: 서버가 List가 아닌 응답을 반환했습니다. 응답: $jsonData');
      }
    } catch (e) {
      // JSON 파싱 중 다른 오류 발생 시
      throw Exception('JSON 파싱 오류: $e');
    }
  }
}