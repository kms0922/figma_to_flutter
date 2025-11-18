import 'package:flutter/material.dart';
//import 'package:figma_to_flutter/screens/sign_up.dart';
import 'package:figma_to_flutter/screens/main_feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SignUpScreen(), 
      home: MainFeedScreen(), 
    );
  }
}