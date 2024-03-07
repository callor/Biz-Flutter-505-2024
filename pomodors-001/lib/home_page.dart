import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, wantTimer});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 변수의 late 초기화하기
  /// flutter(dart)에서는 변수를 반드시 초기화를 해야 하는 원칙이 있다
  /// 즉 변수를 선언만 해서는 문법상 오류가 발생한다.
  /// 이 코드에서 _timer 는 이후 if() 명령문에서
  /// 조건에 따라 초기화를 늦게 시킬예정이다
  /// 처음 변수를 선언할때 초기값을 지정하지 않는다
  /// 이 코드는 flutter(dart)의 변수 초기화 원칙에 위배된다
  /// 이럴때 late 라는 키워드를 부착하여 조금있다가 아래 코드에서
  /// 변수를 꼭!! 초기화 할테니 일단 보류 해달라 라는 의미

  late Timer _timer;
  static const wantTimer = 10;
  int _count = 5;
  bool _timerRun = false;

  void _onPressed() {
    setState(() {
      _timerRun = !_timerRun;
    });
    if (_timerRun) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() => _count--);
          if (_count < 1) {
            _count = wantTimer;
            _timerRun = false;
            timer.cancel();
          }
        },
      );
    } else {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TextButton(
        onPressed: _onPressed,
        child: Center(
          child: Text(
            "$_count",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
