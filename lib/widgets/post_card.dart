// [lib/widgets/post_card.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/model/post_models.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  // 1. 부모 위젯으로부터 onTap 함수를 받기 위한 변수
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    this.onTap, // 2. 생성자에 onTap 추가
  });

  @override
  Widget build(BuildContext context) {
    // 3. InkWell로 감싸고, 외부에서 받은 onTap 콜백 연결
    return InkWell(
      onTap: onTap, 
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
        // 4. 기존 onTap 및 Navigator.push 로직 (제거됨)
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              // 5. 'content'가 아닌 'body' 사용
              Text(
                post.body, 
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                post.createdBy.nickname, // 작성자 닉네임
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}