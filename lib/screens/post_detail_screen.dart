// [lib/screens/post_detail_screen.dart]

import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  // 태그 UI를 만드는 헬퍼(helper) 함수
  Widget _buildTagChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        // ---------------- [수정] ----------------
        color: Colors.grey.shade200, // .shade200으로 변경
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        '#$label',
        style: const TextStyle(color: Colors.black87, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 밝은 테마 색상 설정
    const Color lightBackgroundColor = Colors.white;
    const Color darkTextColor = Colors.black;
    // ---------------- [수정] ----------------
    final Color subtleTextColor = Colors.grey.shade600; // .shade600으로 변경

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: lightBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkTextColor), 
        title: const Text(
          '게시글 이름',
          style: TextStyle(color: darkTextColor, fontWeight: FontWeight.bold),
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
              const Text(
                '게시글 제목',
                style: TextStyle(
                  color: darkTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '이신혁',
                    style: TextStyle(color: subtleTextColor, fontSize: 14),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '2025. 03. 25',
                    style: TextStyle(color: subtleTextColor, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildTagChip('일상'),
                  _buildTagChip('행복'),
                  _buildTagChip('감사'),
                ],
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1557050543-4d5f4e07ef46?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%D&auto=format&fit=crop&w=1932&q=80',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '오늘 아침에 일어나자마자 창밖을 봤는데, 하늘이 분홍색이랑 주황색으로 물들어 있었어요.\n\n사진으로는 다 담기지 않아서 아쉽지만, 기분 좋은 하루의 시작이었네요 😊\n\n다들 좋은 하루 보내세요!',
                style: TextStyle(
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