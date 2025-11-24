import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';
import 'package:figma_to_flutter/data/model/post_models.dart';

class PostDetailScreen extends StatefulWidget {
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
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  // [이미지 처리 로직 - PostCard와 동일]
  Widget _buildDetailImage(String imageString) {
    try {
      if (imageString.startsWith('http') || imageString.startsWith('/')) {
        return Image.network(
          _getValidImageUrl(imageString),
          fit: BoxFit.cover,
        );
      }

      String cleanBase64 = imageString;
      if (imageString.contains(',')) {
        cleanBase64 = imageString.split(',').last;
      }
      Uint8List decodedBytes = base64Decode(cleanBase64);

      return Image.memory(
        decodedBytes,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
      );
    } catch (e) {
      return const Icon(Icons.error);
    }
  }

  String _getValidImageUrl(String rawUrl) {
    if (rawUrl.startsWith('http')) return rawUrl;
    const String baseUrl = 'https://api.bulletin.newbies.gistory.me';
    return rawUrl.startsWith('/') ? '$baseUrl$rawUrl' : '$baseUrl/$rawUrl';
  }

  @override
  Widget build(BuildContext context) {
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
            return Center(child: Text('오류: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('데이터가 없습니다.'));
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
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(post.createdBy.nickname, style: const TextStyle(fontWeight: FontWeight.w500)),
                      const Spacer(),
                      Text(_formatDate(post.createdAt), style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // 이미지 슬라이더
                  if (post.images.isNotEmpty)
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        itemCount: post.images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: _buildDetailImage(post.images[index].image),
                            ),
                          );
                        },
                      ),
                    ),
                  
                  if (post.images.isNotEmpty) const SizedBox(height: 24),
                  Text(post.body, style: const TextStyle(fontSize: 16, height: 1.5)),
                  const SizedBox(height: 24),
                  if (post.tags.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: post.tags.map((tag) => Chip(label: Text('#$tag'))).toList(),
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