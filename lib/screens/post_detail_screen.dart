import 'package:figma_to_flutter/data/model/post_model.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  // PostModel 객체를 생성자를 통해 받음
  final PostModel post;

  const PostDetailScreen({
    super.key,
    required this.post,
  });

  // 태그 UI (API에 없으므로 임시로 헬퍼 함수만 남겨둠)
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

  // 날짜 형식 변환 (예: 2025-11-17T10:00:00 -> 2025. 11. 17)
  String _formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      // 년. 월. 일 형식으로 변경
      return '${dateTime.year}. ${dateTime.month.toString().padLeft(2, '0')}. ${dateTime.day.toString().padLeft(2, '0')}';
    } catch (e) {
      // 파싱 실패 시 원본 반환
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
          post.title, // AppBar 제목도 게시글 제목으로
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
              // 1. 게시글 제목 (모델 데이터 사용)
              Text(
                post.title,
                style: const TextStyle(
                  color: darkTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // 2. 작성자, 날짜 (모델 데이터 사용)
              Row(
                children: [
                  // 'author'는 API 응답에 없으므로 '익명'으로 대체
                  Text(
                    '익명',
                    style: TextStyle(color: subtleTextColor, fontSize: 14),
                  ),
                  const SizedBox(width: 12),
                  // 'createdAt' 데이터 사용 및 형식 변환
                  Text(
                    _formatDate(post.createdAt),
                    style: TextStyle(color: subtleTextColor, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 3. 태그 (API 응답에 없으므로 비워둠)
              // Row(
              //   children: [
              //     _buildTagChip('일상'),
              //     _buildTagChip('행복'),
              //     _buildTagChip('감사'),
              //   ],
              // ),
              // const SizedBox(height: 24),

              // 4. 이미지 (API 응답에 없으므로 비워둠)
              // ClipRRect(...)
              // const SizedBox(height: 24),

              // 5. 본문 내용 (모델 데이터 사용)
              Text(
                post.content,
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