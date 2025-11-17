// [lib/data/data_source/remote/post_api.dart]

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:figma_to_flutter/data/model/post_model.dart';
// 1. 새로 만든 응답 모델 import
import 'package:figma_to_flutter/data/model/post_list_response_model.dart';

part 'post_api.g.dart';

@RestApi(baseUrl: 'https://api.bulletin.newbies.gistory.me')
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  // 2. 반환 타입을 Future<PostListResponseModel>로 수정
  @GET('/boards/{boardId}/posts')
  Future<PostListResponseModel> getPosts(@Path('boardId') int boardId);

  // 3. 새 게시글 작성 메소드
  @POST('/boards/{boardId}/posts')
  Future<PostModel> createPost(
    @Path('boardId') int boardId,
    @Body() Map<String, dynamic> postData,
  );
}