// [lib/data/data_source/remote/post_api.dart]

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
// 1. PostModel을 import 합니다 (응답 타입으로 사용)
import 'package:figma_to_flutter/data/model/post_model.dart';

part 'post_api.g.dart'; // 코드 생성을 위한 부분

// API의 기본 URL
@RestApi(baseUrl: 'https://api.bulletin.newbies.gistory.me')
abstract class PostApi {
  // Retrofit이 _PostApi 클래스를 생성할 수 있도록 factory 생성자 정의
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  // GET /boards/{boardId}/posts
  // 특정 게시판의 게시글 목록 가져오기
  @GET('/boards/{boardId}/posts')
  Future<List<PostModel>> getPosts(@Path('boardId') int boardId);

  // 2. POST /boards/{boardId}/posts (새 메소드 추가)
  // API 명세에 따라, @Body로 Map<String, dynamic>을 보내고,
  // 응답으로는 생성된 PostModel을 받습니다.
  @POST('/boards/{boardId}/posts')
  Future<PostModel> createPost(
    @Path('boardId') int boardId,
    @Body() Map<String, dynamic> postData,
  );
}