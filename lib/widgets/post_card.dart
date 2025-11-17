import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/model/post_model.dart';
import 'package:figma_to_flutter/screens/post_detail_screen.dart';

class PostCard extends StatelessWidget {
  // title, content 대신 PostModel을 직접 받음
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 탭하면 PostDetailScreen으로 PostModel 객체 전달
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(post: post),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // API 응답에 imageUrl이 없으므로 해당 로직 제거

              // 1. 게시글 제목 (모델 데이터 사용)
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // 2. 게시글 내용 (모델 데이터 사용)
              Text(
                post.content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                maxLines: 2, // 내용은 2줄까지만 보이도록
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}