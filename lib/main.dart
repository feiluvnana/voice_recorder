import 'package:flutter/material.dart';
import 'pages/chat_page.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: ChatPage()),
  ));
}
