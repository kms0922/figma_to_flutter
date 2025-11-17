// [lib/screens/create_post_screen.dart]

import 'package:dio/dio.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  final int boardId; // 어느 게시판에 글을 쓸지 ID를 받습니다.

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
  final _contentController = TextEditingController();
  bool _isLoading = false;

  // --- 밝은 테마 색상 ---
  final Color _backgroundColor = Colors.white;
  final Color _textColor = Colors.black;
  final Color _hintColor = Colors.grey.shade400; // 밝은 힌트 색상
  final Color _dividerColor = Colors.grey.shade300; // 밝은 구분선 색상
  final Color _buttonColor = Colors.blue;
  // ---

  @override
  void initState() {
    super.initState();
    _postApi = PostApi(Dio());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitPost() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목과 내용을 모두 입력해주세요.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final postData = {
        "title": _titleController.text,
        "content": _contentController.text,
      };

      // API 호출 (이제 post_api.dart에 createPost가 있으므로 정상 작동)
      await _postApi.createPost(widget.boardId, postData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('게시글이 성공적으로 작성되었습니다.')),
        );
        Navigator.pop(context, true); // true를 반환하여 이전 화면이 새로고침하도록 함
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
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: _textColor), // 뒤로가기 버튼 색상
        title: Text(
          '게시글 작성',
          style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submitPost,
            child: Text(
              '다음', // '다음' 버튼
              style: TextStyle(
                color: _isLoading ? _hintColor : _buttonColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // 제목 입력
                TextField(
                  controller: _titleController,
                  autofocus: true,
                  style: TextStyle(
                      color: _textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: '곧 벚꽃이 필 것 같아요', // 스크린샷 힌트
                    hintStyle: TextStyle(
                        color: _hintColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                ),
                Divider(color: _dividerColor),
                // 내용 입력
                Expanded(
                  child: TextField(
                    controller: _contentController,
                    style: TextStyle(color: _textColor, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: '아무래도 그렇죠', // 스크린샷 힌트
                      hintStyle: TextStyle(color: _hintColor, fontSize: 16),
                      border: InputBorder.none,
                    ),
                    maxLines: null, // 무제한 줄
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}