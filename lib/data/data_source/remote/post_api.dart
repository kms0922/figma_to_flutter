import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
// 1. PostModel을 import 합니다 (응답 타입으로 사용)
import 'package:figma_to_flutter/data/model/post_model.dart';

part 'post_api.g.dart';

@RestApi(baseUrl: 'https://api.bulletin.newbies.gistory.me')
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  // GET /boards/{boardId}/posts
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