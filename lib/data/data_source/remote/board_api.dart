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
      
      // JSON 리스트를 List<dynamic>으로 파싱
      List<dynamic> jsonList = jsonDecode(responseBody);

      // 리스트의 각 항목을 BoardModel로 변환
      return jsonList.map((json) => BoardModel.fromJson(json)).toList();
    } else {
      // 에러 처리
      throw Exception('Failed to load boards');
    }
  }
}