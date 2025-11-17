// [lib/data/data_source/remote/board_api.dart]

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:figma_to_flutter/data/model/board_model.dart';
import 'package:figma_to_flutter/data/model/board_list_response_model.dart';

class BoardApi {
  static const String _baseUrl = 'https://api.bulletin.newbies.gistory.me';

  // 반환 타입은 List<BoardModel>로 유지 (UI단에서는 List만 필요)
  Future<List<BoardModel>> getBoards() async {
    final response = await http.get(Uri.parse('$_baseUrl/boards'));

    // 1. Content-Type 헤더 확인
    final contentType = response.headers['content-type'];

    // 2. 상태 코드가 200이 아니거나, Content-Type이 JSON이 아닌 경우 (HTML 오류 등)
    if (response.statusCode != 200 ||
        contentType == null ||
        !contentType.contains('application/json')) {
      String bodySnippet = response.body.length > 200
          ? '${response.body.substring(0, 200)}...'
          : response.body;

      throw Exception(
          '오류: 서버가 JSON이 아닌 응답을 반환했습니다.\n'
          'Status Code: ${response.statusCode}\n'
          'Content-Type: $contentType\n'
          '응답 (일부): $bodySnippet');
    }

    // 3. 이제 응답이 JSON임을 확신하고 파싱
    try {
      String responseBody = utf8.decode(response.bodyBytes);
      
      // 4. 응답을 Map<String, dynamic>으로 파싱
      final Map<String, dynamic> jsonData = jsonDecode(responseBody);

      // 5. BoardListResponseModel을 사용해 파싱 (이제 'list' 키를 읽음)
      final boardResponse = BoardListResponseModel.fromJson(jsonData);

      // 6. 실제 데이터인 data (List<BoardModel>)를 반환
      return boardResponse.data;

    } catch (e) {
      // JSON 파싱 중 다른 오류 (예: 모델 필드 불일치)
      throw Exception('JSON 파싱 오류: $e');
    }
  }
}