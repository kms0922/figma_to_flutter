// [lib/screens/main_feed_screen.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/data_source/remote/board_api.dart';
import 'package:figma_to_flutter/data/model/board_models.dart';
import 'package:figma_to_flutter/screens/post_list_screen.dart';

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
        // ... (이하 동일)
      ),
      body: FutureBuilder<List<BoardModel>>(
        future: _boardsFuture,
        builder: (context, snapshot) {
          // ... (로딩/에러 처리 동일)

          final boards = snapshot.data!;

          return ListView.builder(
            itemCount: boards.length,
            itemBuilder: (context, index) {
              final board = boards[index];
              return Card(
                // ... (Card 스타일 동일)
                child: ListTile(
                  // 1. board.name -> board.title로 변경
                  title: Text(board.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  // 2. board.description -> board.creator.nickname (작성자)
                  subtitle: Text('작성자: ${board.creator.nickname}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostListScreen(
                          boardId: board.id,
                          // 3. board.name -> board.title로 변경
                          boardName: board.title,
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