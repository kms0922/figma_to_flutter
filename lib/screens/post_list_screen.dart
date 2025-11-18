// [lib/screens/post_list_screen.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';
import 'package:figma_to_flutter/data/model/post_models.dart';
import 'package:figma_to_flutter/screens/create_post_screen.dart';
import 'package:figma_to_flutter/screens/post_detail_screen.dart';
import 'package:figma_to_flutter/widgets/post_card.dart';

class PostListScreen extends StatefulWidget {
  final String boardId;
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
    _postApi = PostApi();
    _loadPosts();
  }

  void _loadPosts() {
    _postsFuture = _postApi.getPosts(widget.boardId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(widget.boardName),
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _postsFuture,
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

          final posts = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _loadPosts();
              });
            },
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCard(
                  post: post,
                  // 1. PostCard에 onTap 콜백 전달
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // 2. [오류 수정] PostDetailScreen에
                        // 'post' 객체가 아닌 'postId'와 'postTitle' 전달
                        builder: (context) => PostDetailScreen(
                          postId: post.id,
                          postTitle: post.title,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostScreen(boardId: widget.boardId),
            ),
          );
          if (result == true) {
            setState(() {
              _loadPosts();
            });
          }
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit),
      ),
    );
  }
}