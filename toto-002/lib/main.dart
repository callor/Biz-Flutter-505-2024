import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toto/model/todo.dart';
import 'package:toto/service/todo_service.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoHome(),
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({
    super.key,
  });

  /// State<> 클래스를 생성하여 화면을 그리는 객체로 만들기
  @override
  State<TodoHome> createState() => _TodoHomeState();
}

/// State<> 화면에 변화되는 변수를 사용하거나, 여러가지 interactive 한
/// 화면을 구현하는 Widget class
class _TodoHomeState extends State<TodoHome> {
  /// TextField 에 ID(refs)를 부착하기 위한 state
  final todoInputController = TextEditingController();
  String todo = "";

  getTodo(String todo) {
    return Todo(
      id: const Uuid().v4(),
      // 현재 디바이스의 날짜를 가져와서(DateTime.now())
      // 문자열 형식으로 변환하라
      sdate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      stime: DateFormat("HH:ss:mm").format(DateTime.now()),
      edate: "",
      etime: "",
      content: todo,
      complete: false,
    );
    // return todoDto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("TODO List")),
        bottomSheet: bottomSheet(context),

        /// FutreBuilder
        /// 데이터베이스에서 가져온 List<Todo> 데이터를 화면에 표현하기 위한
        /// 빌더(생성자, 만들기함수)
        /// selectAll() 한 데이터를 future 속성에 주입
        /// 내부에서 가공되어 buider 의 snapshot 에 다시 데이터를 전달한다
        body: todoListBody());
  }

  Widget todoListBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder(
            future: TodoService().selectAll(),
            builder: (context, snapshot) {
              /// snapshot.data 의 데이터를 List<Todo> type 으로 변환하여 todoList에 할당
              var todoList = snapshot.data as List<Todo>;

              /// todoList snapshot data 를 가지고 실제 list 를 화면에 그리는 도구
              return ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Text(todoList[index].content);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: todoInputController,
              onChanged: (value) => {setState(() => todo = value)},
              decoration: InputDecoration(
                  hintText: "할일을 입력하세요",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  prefix: const SizedBox(width: 20),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => {todoInputController.clear()},
                        icon: const Icon(Icons.clear),
                      ),
                      IconButton(
                        onPressed: () async {
                          var snackbar = SnackBar(content: Text(todo));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);

                          var todoDto = getTodo(todo);

                          /// SW 키보드 감추기
                          FocusScope.of(context).unfocus();
                          await TodoService().insert(todoDto);
                          todoInputController.clear();
                        },
                        icon: const Icon(Icons.send_outlined),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
