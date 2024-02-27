import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple",
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: Colors.blue,
      ),
      body: const AppBody(),
      floatingActionButton: actionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// context : 현재 보고 있는 화면(App)
  /// 기본 Wedget 아닌 Alert 등을 띄울때는 어떤 context 를 대상으로
  /// 실행할 것인지를 명시해 주어야 한다.
  /// flutter 에서는 context 라는 대상이 많이 나온다
  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("안녕"),
          content: const Text("반갑습니다"),
          actions: [
            TextButton(
              // 현재 alert popup 창 닫기
              onPressed: () => Navigator.pop(context, "취소"),
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, "확인"),
              child: const Text("확인"),
            )
          ],
        );
      },
    );
  }

  FloatingActionButton actionButton() {
    return FloatingActionButton.extended(
      onPressed: () => {_showDialog()},
      label: const Text("Click"),
      isExtended: true,
      icon: const Icon(Icons.add_a_photo, size: 30),
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 30,
    );
  }
}

class AppBody extends StatelessWidget {
  const AppBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("대한민국",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
              )),
          Text("우리나라만세"),
          Text("Republic of Korea"),
        ],
      ),
    );
  }
}
