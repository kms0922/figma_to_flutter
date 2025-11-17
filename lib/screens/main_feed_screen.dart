// [lib/screens/main_feed_screen.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/data_source/remote/board_api.dart';
import 'package:figma_to_flutter/data/model/board_model.dart';
import 'package:figma_to_flutter/screens/post_list_screen.dart'; // 새로 만들 PostListScreen

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  int _selectedIndex = 0;

  late final BoardApi _boardApi;
  late Future<List<BoardModel>> _boardsFuture;

  @override
  void initState() {
    super.initState();
    _boardApi = BoardApi();
    _boardsFuture = _boardApi.getBoards();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          '나의 게시판 앱',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          // '새 글 작성' 아이콘은 PostListScreen으로 이동
        ],
      ),
      // body를 FutureBuilder로 변경
      body: FutureBuilder<List<BoardModel>>(
        future: _boardsFuture, // http.getBoards() 호출
        builder: (context, snapshot) {
          // 로딩 중일 때
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 에러 발생 시 (수정된 board_api.dart의 상세 오류가 표시됨)
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          // 데이터가 없을 때
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('게시판이 없습니다.'));
          }

          // 데이터 로드 성공 시
          final boards = snapshot.data!;

          // Board 목록을 ListView로 표시
          return ListView.builder(
            itemCount: boards.length,
            itemBuilder: (context, index) {
              final board = boards[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
                child: ListTile(
                  title: Text(board.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(board.description),
                  // 탭하면 PostListScreen으로 boardId와 boardName을 들고 이동
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostListScreen(
                          boardId: board.id,
                          boardName: board.name,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
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
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
    );
  }
}