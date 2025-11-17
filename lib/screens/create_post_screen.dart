import 'dart:io'; // File 클래스를 사용하기 위해 import
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // image_picker 패키지 import

class CreatePostScreen extends StatefulWidget {
  // 어떤 게시판에 글을 쓸지 결정하는 boardId를 받아옵니다.
  // 이 화면이 호출되기 전에 MainFeedScreen 또는 PostListScreen에서 boardId를 정해줘야 합니다.
  final int? boardId; // boardId가 필수가 아니라면 null 허용

  const CreatePostScreen({super.key, this.boardId});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker(); // ImagePicker 인스턴스
  final List<XFile> _images = []; // 선택된 이미지 파일들을 저장할 리스트

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // 갤러리에서 이미지 선택
  Future<void> _pickImage() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage(
      imageQuality: 70, // 이미지 품질 (0-100)
    );
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _images.addAll(selectedImages); // 선택된 이미지들을 리스트에 추가
      });
    }
  }

  // 이미지 미리보기 삭제
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  // 게시글 작성 (API 연동은 추후에)
  void _submitPost() {
    // TODO: 여기에 게시글 데이터와 이미지 파일들을 백엔드 API로 전송하는 로직을 구현합니다.
    // 현재는 단순히 콘솔에 출력하고 이전 화면으로 돌아갑니다.
    print('게시글 제목: ${_titleController.text}');
    print('게시글 내용: ${_contentController.text}');
    print('첨부된 이미지 수: ${_images.length}');
    for (var img in _images) {
      print('이미지 경로: ${img.path}');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('게시글 작성 완료 (API 연동 필요)')),
    );
    Navigator.pop(context); // 이전 화면으로 돌아가기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          '게시글 작성',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: _submitPost, // '다음' 버튼
              child: const Text(
                '다음',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 제목 입력 필드
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요',
                hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                border: InputBorder.none, // 테두리 없음
                contentPadding: EdgeInsets.zero, // 기본 패딩 제거
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              maxLines: null, // 여러 줄 입력 가능
            ),
            const Divider(height: 20, thickness: 1, color: Color(0xFFE0E0E0)), // 구분선

            // 2. 내용 입력 필드
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: '무슨 일이 있었는지 알려주세요',
                hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              maxLines: null, // 여러 줄 입력 가능
              minLines: 5, // 최소 5줄
            ),
            const SizedBox(height: 20),

            // 3. 이미지 미리보기 및 추가 버튼
            SizedBox(
              height: 100, // 이미지 미리보기 영역 높이 고정
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // 가로 스크롤
                itemCount: _images.length + 1, // 선택된 이미지 수 + '사진 추가' 버튼
                itemBuilder: (context, index) {
                  if (index == _images.length) {
                    // '사진 추가' 버튼
                    return GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 90,
                        height: 90,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_outlined, size: 30, color: Colors.grey.shade600),
                            Text('사진 추가', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  } else {
                    // 선택된 이미지 미리보기
                    return Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(File(_images[index].path)), // FileImage 사용
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // 삭제 버튼
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}