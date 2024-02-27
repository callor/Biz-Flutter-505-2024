import 'package:flutter/material.dart';
import 'modules/todo_app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TODO",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoApp(),
    );
  }
}
