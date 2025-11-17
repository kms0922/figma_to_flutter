// [lib/screens/post_detail_screen.dart]

// 1. 수정된 모델 파일 import
import 'package:figma_to_flutter/data/model/post_models.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({
    super.key,
    required this.post,
  });

  // (태그 헬퍼 함수는 API에 없으므로 일단 남겨둡니다)
  Widget _buildTagChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        '#$label',
        style: const TextStyle(color: Colors.black87, fontSize: 12),
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return '${dateTime.year}. ${dateTime.month.toString().padLeft(2, '0')}. ${dateTime.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color lightBackgroundColor = Colors.white;
    const Color darkTextColor = Colors.black;
    final Color subtleTextColor = Colors.grey.shade600;

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: lightBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkTextColor),
        title: Text(
          post.title, // 2. AppBar 제목
          style: const TextStyle(
              color: darkTextColor, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: darkTextColor),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: darkTextColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title, // 3. 본문 제목
                style: const TextStyle(
                  color: darkTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  // 4. '익명' 대신 post.creator.nickname 사용
                  Text(
                    post.creator.nickname,
                    style: TextStyle(color: subtleTextColor, fontSize: 14),
                  ),
                  const SizedBox(width: 12),
                  // 5. post.createdAt 사용
                  Text(
                    _formatDate(post.createdAt),
                    style: TextStyle(color: subtleTextColor, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // (API에 태그, 이미지가 없으므로 관련 UI는 주석 처리)

              Text(
                post.content, // 6. 본문 내용
                style: const TextStyle(
                  color: darkTextColor,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}