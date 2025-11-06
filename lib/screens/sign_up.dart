import 'package:flutter/material.dart';
import 'package:figma_to_flutter/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0), // 상하 여백 추가
        child: Column(
          children: [
            CustomTextField(
              label: '닉네임',
              hintText: '닉네임을 입력하세요.',
            ),
            SizedBox(height: 24), // 각 입력 필드 사이의 간격
            CustomTextField(
              label: '이메일',
              hintText: '이메일을 입력하세요.',
            ),
            SizedBox(height: 24),
            CustomTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력하세요.',
            ),
          ],
        ),
      ),
    );
  }
}