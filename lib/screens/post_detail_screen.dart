// [lib/screens/post_detail_screen.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';
import 'package:figma_to_flutter/data/model/post_models.dart';
import 'package:intl/intl.dart';

// 1. StatefulWidget으로 변경
class PostDetailScreen extends StatefulWidget {
  final String postId;
  final String postTitle; // AppBar 제목용

  const PostDetailScreen({
    super.key,
    required this.postId,
    required this.postTitle,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  // 2. API 및 Future 상태 변수 추가
  late final PostApi _postApi;
  late Future<PostModel> _postFuture;

  @override
  void initState() {
    super.initState();
    _postApi = PostApi();
    // 3. initState에서 상세 데이터 요청
    _postFuture = _postApi.getPostDetail(widget.postId);
  }

  // 날짜 포맷 함수
  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      // 4. 날짜 형식을 'yyyy-MM-dd HH:mm' (연-월-일 시:분)으로 변경
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      return dateString; // 파싱 실패 시 원본 문자열 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        // 5. 생성자에서 받은 AppBar 제목 사용 (데이터 로딩 전에도 표시됨)
        title: Text(widget.postTitle),
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      // 6. FutureBuilder로 body를 감싸서 API 응답 처리
      body: FutureBuilder<PostModel>(
        future: _postFuture,
        builder: (context, snapshot) {
          // 7. 로딩 중 처리
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 8. 에러 발생 시 처리
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('오류가 발생했습니다: ${snapshot.error}'),
              ),
            );
          }

          // 9. 데이터가 없는 경우 처리
          if (!snapshot.hasData) {
            return const Center(child: Text('게시글 데이터를 불러올 수 없습니다.'));
          }

          // 10. 데이터 로드 성공 시, 'post' 변수에 할당
          final post = snapshot.data!;

          // 11. 기존 UI 로직 (SingleChildScrollView) 반환
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 작성자 및 작성일
                  Row(
                    children: [
                      Text(
                        post.createdBy.nickname, // API 스펙에 맞게 'createdBy' 사용
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(post.createdAt), // API 스펙에 맞게 'createdAt' 사용
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // 이미지 (여러 개일 수 있으므로 PageView 사용)
                  if (post.images.isNotEmpty)
                    SizedBox(
                      height: 250, // 이미지 높이 고정
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
                                image.image, // API 스펙에 맞게 'image.image' 사용
                                fit: BoxFit.cover,
                                // 이미지 로딩 중/에러 처리
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

                  // 본문 내용 (API 스펙에 맞게 'body' 사용)
                  Text(
                    post.body,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // 태그 (API 스펙에 맞게 'tags' 사용)
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