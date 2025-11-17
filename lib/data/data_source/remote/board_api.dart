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

    if (response.statusCode == 200) {
      // UTF-8로 디코딩하여 한글 깨짐 방지
      String responseBody = utf8.decode(response.bodyBytes);

      // --- [오류 수정] ---
      // 1. jsonDecode의 결과를 dynamic으로 받습니다.
      final dynamic jsonData = jsonDecode(responseBody);

      // 2. 타입이 List인지 확인합니다.
      if (jsonData is List) {
        // 3. List가 맞으면 기존 로직 수행
        List<dynamic> jsonList = jsonData;
        return jsonList.map((json) => BoardModel.fromJson(json)).toList();
      }
      // 4. Map이 반환된 경우 (에러 객체 등)
      else if (jsonData is Map) {
        throw Exception(
            '오류: 서버에서 List가 아닌 Map을 반환했습니다. 응답: $jsonData');
      }
      // 5. 그 외의 경우
      else {
        throw Exception('오류: 알 수 없는 형태의 응답입니다. 응답: $jsonData');
      }
      // --- [수정 끝] ---

    } else {
      // 에러 처리
      throw Exception('게시판 목록을 불러오는데 실패했습니다: ${response.statusCode}');
    }
  }
}