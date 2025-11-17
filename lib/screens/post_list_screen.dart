// [lib/screens/post_list_screen.dart]

import 'package:dio/dio.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';
import 'package:figma_to_flutter/data/model/post_model.dart';
// 1. 새로 만든 응답 모델 import
import 'package:figma_to_flutter/data/model/post_list_response_model.dart';
import 'package:figma_to_flutter/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:figma_to_flutter/screens/create_post_screen.dart';

class PostListScreen extends StatefulWidget {
  final int boardId;
  final String boardName;

  const PostListScreen({
    super.key,
    required this.boardId,
    required this.boardName,
  });

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late final PostApi _postApi;
  // 2. Future의 타입을 PostListResponseModel로 수정
  late Future<PostListResponseModel> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postApi = PostApi(Dio());
    _loadPosts();
  }

  void _loadPosts() {
    // 3. post_api.getPosts()는 이제 PostListResponseModel을 반환
    _postsFuture = _postApi.getPosts(widget.boardId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(widget.boardName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreatePostScreen(boardId: widget.boardId),
                ),
              );
              if (result == true) {
                setState(() {
                  _loadPosts();
                });
              }
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      // 4. FutureBuilder의 타입도 PostListResponseModel로 수정
      body: FutureBuilder<PostListResponseModel>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
          }
          // 5. 스냅샷 데이터에서 data 필드를 추출
          if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(child: Text('게시글이 없습니다.'));
          }

          // 6. snapshot.data.data (List<PostModel>)를 사용
          final posts = snapshot.data!.data;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post: post);
            },
          );
        },
      ),
    );
  }
}