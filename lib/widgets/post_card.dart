import 'dart:convert'; // Base64 디코딩용
import 'dart:typed_data'; // 바이트 데이터 처리용
import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/model/post_models.dart';
import 'package:figma_to_flutter/screens/post_detail_screen.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
  });

  // [핵심 로직] 이미지 데이터를 분석해서 알맞게 그려주는 함수
  Widget _buildPostImage(String imageString) {
    try {
      // 1. 만약 http나 /로 시작하면 -> URL 이미지로 처리
      if (imageString.startsWith('http') || imageString.startsWith('/')) {
        return Image.network(
          _getValidImageUrl(imageString),
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildLoadingBox();
          },
          errorBuilder: (context, error, stackTrace) => _buildErrorBox(),
        );
      }

      // 2. 그 외에는 Base64 데이터(WebP, PNG 등)로 처리
      // "data:image/webp;base64," 같은 헤더가 붙어있을 경우 제거
      String cleanBase64 = imageString;
      if (imageString.contains(',')) {
        cleanBase64 = imageString.split(',').last;
      }

      // Base64 디코딩 (문자열 -> 이미지 바이트 데이터)
      Uint8List decodedBytes = base64Decode(cleanBase64);

      return Image.memory(
        decodedBytes,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('이미지 렌더링 오류: $error');
          return _buildErrorBox();
        },
      );

    } catch (e) {
      debugPrint('이미지 처리 실패: $e');
      return _buildErrorBox();
    }
  }

  // URL 보정 헬퍼 함수
  String _getValidImageUrl(String rawUrl) {
    if (rawUrl.startsWith('http')) return rawUrl;
    const String baseUrl = 'https://api.bulletin.newbies.gistory.me';
    return rawUrl.startsWith('/') ? '$baseUrl$rawUrl' : '$baseUrl/$rawUrl';
  }

  // 로딩 중일 때 보여줄 박스
  Widget _buildLoadingBox() {
    return Container(
      height: 150,
      color: Colors.grey[200],
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

  // 에러 났을 때 보여줄 박스
  Widget _buildErrorBox() {
    return Container(
      height: 150,
      color: Colors.grey[200],
      child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지가 있으면 표시
            if (post.images.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: _buildPostImage(post.images[0].image),
              ),
            
            // 텍스트 내용
            Padding(
              padding: const EdgeInsets.all(12),
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
                  const SizedBox(height: 5),
                  Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    post.createdBy.nickname,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}