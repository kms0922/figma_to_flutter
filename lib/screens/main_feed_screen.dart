// [lib/screens/main_feed_screen.dart]

import 'package:flutter/material.dart';
import 'package:figma_to_flutter/data/data_source/remote/post_api.dart';
import 'package:figma_to_flutter/data/model/post_models.dart';
import 'package:figma_to_flutter/screens/create_post_screen.dart';
import 'package:figma_to_flutter/screens/post_detail_screen.dart';
import 'package:figma_to_flutter/widgets/post_card.dart';

class MainFeedScreen extends StatefulWidget {
  const MainFeedScreen({super.key});

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  int _selectedIndex = 0;

  late final PostApi _postApi;
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postApi = PostApi();
    _loadPosts();
  }

  void _loadPosts() {
    _postsFuture = _postApi.getPosts();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 1. 글 작성 버튼 클릭 시 실행될 함수를 분리
  void _navigateToCreatePost() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatePostScreen(),
      ),
    );
    // 글 작성이 완료되면 목록 새로고침
    if (result == true) {
      setState(() {
        _loadPosts();
      });
    }
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
        // 2. actions 섹션 수정
        actions: [
          IconButton(
            onPressed: () {
              // 돋보기 버튼 로직 (현재는 비어 있음)
            },
            icon: const Icon(Icons.search),
          ),
          // 3. 연필 아이콘 버튼 추가
          IconButton(
            onPressed: _navigateToCreatePost, // 4. 분리한 함수 연결
            icon: const Icon(Icons.edit), // 연필 아이콘
          ),
        ],
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '오류가 발생했습니다: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('게시글이 없습니다.'));
          }

          final posts = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _loadPosts();
              });
            },
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCard(
                  post: post,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(
                          postId: post.id,
                          postTitle: post.title,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      // 5. FloatingActionButton 제거
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _navigateToCreatePost,
      //   backgroundColor: Colors.black,
      //   foregroundColor: Colors.white,
      //   child: const Icon(Icons.edit),
      // ),
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