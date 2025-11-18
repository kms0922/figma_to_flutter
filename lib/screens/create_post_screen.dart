// [lib/screens/create_post_screen.dart] (수정)

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';

class CreatePostScreen extends StatefulWidget {
  final String boardId;

  const CreatePostScreen({
    super.key,
    required this.boardId,
  });

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late final PostApi _postApi;
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController(); // content -> body
  final _tagsController = TextEditingController(); // tags 추가
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _postApi = PostApi(); // Dio 인스턴스 제거 (post_api.dart에서 자체 생성)
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _submitPost() async {
    // 1. body(본문) 컨트롤러로 유효성 검사 수정
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목과 내용을 모두 입력해주세요.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 2. 태그 컨트롤러의 텍스트를 쉼표(,)로 분리하여 List<String> 생성
      final tags = _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty) // 빈 태그 제거
          .toList();

      // 3. API 명세에 맞게 title, body, tags를 개별 인자로 전달
      await _postApi.createPost(
        widget.boardId,
        _titleController.text,
        _bodyController.text,
        tags,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('게시글이 성공적으로 작성되었습니다.')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('새 게시물'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submitPost,
            child: Text(
              '완료',
              style: TextStyle(
                color: _isLoading ? Colors.grey : Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: '제목',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  // 4. 본문 컨트롤러 연결
                  TextField(
                    controller: _bodyController,
                    decoration: const InputDecoration(
                      hintText: '내용을 입력하세요...',
                      border: InputBorder.none,
                    ),
                    maxLines: 10,
                  ),
                  const Divider(),
                  // 5. 태그 입력 필드 추가
                  TextField(
                    controller: _tagsController,
                    decoration: const InputDecoration(
                      hintText: '태그 (쉼표로 구분)',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            // 6. withOpacity 경고 수정 (오류 4)
            Container(
              color: Colors.black.withAlpha(77), // 0.3 * 255 = 76.5
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}