// [lib/data/data_source/remote/post_api.dart]

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:figma_to_flutter/data/model/post_model.dart';

part 'post_api.g.dart'; // 코드 생성을 위한 부분

@RestApi(baseUrl: 'https://api.bulletin.newbies.gistory.me')
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  // GET /boards/{boardId}/posts
  @GET('/boards/{boardId}/posts')
  Future<List<PostModel>> getPosts(@Path('boardId') int boardId);

  // POST /boards/{boardId}/posts (새 메소드 추가)
  @POST('/boards/{boardId}/posts')
  Future<PostModel> createPost(
    @Path('boardId') int boardId,
    @Body() Map<String, dynamic> postData,
  );
}