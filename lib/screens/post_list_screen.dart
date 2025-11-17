// [lib/screens/post_list_screen.dart]

import 'package:dio/dio.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';
import 'package:figma_to_flutter/data/model/post_model.dart';
import 'package:figma_to_flutter/widgets/post_card.dart';
import 'package:flutter/material.dart';
// 1. CreatePostScreen import
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
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postApi = PostApi(Dio());
    // 2. API 호출을 별도 함수로 분리 (새로고침을 위해)
    _loadPosts();
  }

  // 3. API 호출을 별도 함수로 분리
  void _loadPosts() {
    _postsFuture = _postApi.getPosts(widget.boardId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(widget.boardName), // 전달받은 게시판 이름 표시
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // 4. '새 글 작성' 아이콘 추가
        actions: [
          IconButton(
            onPressed: () async {
              // CreatePostScreen으로 이동
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreatePostScreen(boardId: widget.boardId),
                ),
              );

              // 5. 글 작성을 완료하고 돌아왔으면(result == true) 목록 새로고침
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
      body: FutureBuilder<List<PostModel>>(
        future: _postsFuture, // retrofit.getPosts()
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('게시글이 없습니다.'));
          }

          // 게시글 목록을 PostCard를 사용해 표시
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              // PostCard에 PostModel 전달
              return PostCard(post: post);
            },
          );
        },
      ),
    );
  }
}