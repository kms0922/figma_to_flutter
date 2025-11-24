// [lib/widgets/post_card.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/model/post_models.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
  });

  // [이미지 URL 처리 함수]
  // 이미지 주소가 'http'로 시작하지 않으면(상대 경로면) 서버 도메인을 앞에 붙여줍니다.
  String _getValidImageUrl(String rawUrl) {
    if (rawUrl.startsWith('http')) {
      return rawUrl;
    }

    // 서버 도메인 (API 주소와 동일하게 맞춤)
    const String baseUrl = 'https://api.bulletin.newbies.gistory.me';

    // URL이 '/'로 시작하는지 여부에 따라 처리
    if (rawUrl.startsWith('/')) {
      return '$baseUrl$rawUrl';
    } else {
      return '$baseUrl/$rawUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
              // 1. 이미지가 있는지 확인 (리스트가 비어있지 않으면 표시)
              if (post.images.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      // 첫 번째 이미지의 URL을 가져와서 변환
                      _getValidImageUrl(post.images[0].image),
                      height: 180, // 이미지 높이 고정
                      width: double.infinity, // 너비는 카드에 맞춤
                      fit: BoxFit.cover, // 꽉 차게 표시
                      
                      // 로딩 중일 때 표시할 위젯
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 180,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                      
                      // 이미지 로드 실패 시 표시할 위젯
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              // 2. 게시글 제목
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

              // 3. 게시글 본문
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

              // 4. 작성자 닉네임
              Text(
                post.createdBy.nickname,
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