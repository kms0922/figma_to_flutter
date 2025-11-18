// [lib/screens/post_detail_screen.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';
import 'package:figma_to_flutter/data/model/post_models.dart';
// 1. [오류 수정] 'intl' 패키지 import 추가
import 'package:intl/intl.dart';

class PostDetailScreen extends StatefulWidget {
  // ... (기존 코드 동일)
  final String postId;
  final String postTitle;

  const PostDetailScreen({
    super.key,
    required this.postId,
    required this.postTitle,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  // ... (기존 코드 동일)
  late final PostApi _postApi;
  late Future<PostModel> _postFuture;

  @override
  void initState() {
    super.initState();
    _postApi = PostApi();
    _postFuture = _postApi.getPostDetail(widget.postId);
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      // 2. DateFormat이 정상적으로 인식됨
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... (이하 build 메서드 전체 동일)
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(widget.postTitle),
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<PostModel>(
        future: _postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('오류가 발생했습니다: ${snapshot.error}'),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('게시글 데이터를 불러올 수 없습니다.'));
          }

          final post = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        post.createdBy.nickname,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(post.createdAt),
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  if (post.images.isNotEmpty)
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        itemCount: post.images.length,
                        itemBuilder: (context, index) {
                          final image = post.images[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                image.image,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.error),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  if (post.images.isNotEmpty) const SizedBox(height: 24),
                  Text(
                    post.body,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  if (post.tags.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: post.tags
                          .map((tag) => Chip(
                                label: Text('#$tag'),
                                backgroundColor: Colors.grey[200],
                                labelStyle: const TextStyle(color: Colors.black),
                                side: BorderSide.none,
                              ))
                          .toList(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}