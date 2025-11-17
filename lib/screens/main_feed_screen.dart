// [lib/screens/main_feed_screen.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/widgets/post_card.dart'; // 방금 만든 PostCard를 가져옵니다.

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  int _selectedIndex = 0; // 하단 탭의 선택된 인덱스

  // --- 테스트를 위한 임시 데이터 ---
  // 나중에는 이 데이터를 서버나 데이터베이스에서 가져오게 됩니다.
  final List<Map<String, String?>> posts = [
    {
      "title": "게시글 제목",
      "content": "공지 내용",
      "imageUrl": null, // 이미지가 없는 게시글
    },
    {
      "title": "게시글 제목",
      "content": "공지 내용",
      "imageUrl": null,
    },
    {
      "title": "게시글 제목",
      "content": "공지 내용",
      "imageUrl": null,
    },
    {
      "title": "게시글 제목",
      "content": "공지 내용",
      "imageUrl": null,
    },
    {
      "title": "게시글 제목",
      "content": "공지 내용",
      "imageUrl": null,
    },
  ];
  // --- 임시 데이터 끝 ---

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: 탭에 따라 다른 동작을 하도록 구현 (예: 화면 이동)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 화면 배경색을 디자인과 비슷하게 연한 회색으로 설정
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        // AppBar 배경색 및 스타일
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // 아이콘과 글자색
        elevation: 0, // 그림자 제거
        title: const Text(
          '나의 게시판 앱', //
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // 오른쪽 아이콘 버튼들
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length, // 데이터 리스트의 길이만큼
        itemBuilder: (context, index) {
          // 각 항목에 대해 PostCard 위젯을 반환
          final post = posts[index];
          return PostCard(
            title: post['title']!,
            content: post['content']!,
            imageUrl: post['imageUrl'],
          );
        },
      ),
      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: '메뉴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), // person 아이콘
            label: '프로필',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black, // 선택된 아이콘 색상
        unselectedItemColor: Colors.grey[600], // 선택되지 않은 아이콘 색상
        onTap: _onItemTapped,
        showSelectedLabels: false,   // 선택된 라벨 숨기기
        showUnselectedLabels: false, // 선택되지 않은 라벨 숨기기
        backgroundColor: Colors.white,
        elevation: 1.0, // 약간의 그림자
      ),
    );
  }
}