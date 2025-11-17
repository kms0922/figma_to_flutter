// [lib/data/data_source/remote/post_api.dart]

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
// 1. 수정된 모델 파일 import
import 'package:figma_to_flutter/data/model/post_models.dart';

part 'post_api.g.dart';

@RestApi(baseUrl: 'https://api.bulletin.newbies.gistory.me')
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  // 2. 반환 타입을 PostListResponseModel로 수정
  // 3. boardId 타입을 String으로 수정
  @GET('/boards/{boardId}/posts')
  Future<PostListResponseModel> getPosts(@Path('boardId') String boardId);

  // 4. boardId 타입을 String으로 수정
  @POST('/boards/{boardId}/posts')
  Future<PostModel> createPost(
    @Path('boardId') String boardId,
    @Body() Map<String, dynamic> postData,
  );
}