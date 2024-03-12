// ignore_for_file: constant_identifier_names, unused_field, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toto/model/todo.dart';

const TBL_TODO = "tbl_todolist";
const createTodoTable = """
  CREATE TABLE $TBL_TODO (
    id TEXT,
    sdate TEXT,
    stime TEXT,
    edate TEXT,
    etime TEXT,
    content TEXT,
    complete INTEGER
  )
""";

class TodoService {
  late Database _database;
  // Future<Database> get database() async {
  //   _database = await
  // }

  onCreateTable(db, version) async {
    return db.execute(createTodoTable);
  }

  // initData / openDatabase 가 싫행될때
  // version 번호를 비교하여 새로운 version 번호가 있으면
  // Table 의 구조를 변경한다.
  onUpgradeTable(db, oldVersion, newVersion) async {
    debugPrint("VERSION: $oldVersion, $newVersion");
    if (newVersion > oldVersion) {
      final batch = await db.batch();
      await batch.execute("DROP TABLE $TBL_TODO");
      await batch.execute(createTodoTable);
      await batch.commit();
    }
  }

  Future<Database> initDatabase() async {
    // 스마트 기기의 DB 저장소의 위치를 가져오는 함수
    String dbPath = await getDatabasesPath();
    // 만약 폴더1/폴더2/폴더3/todb.dbf 라는 폴더 경로를 설정할때
    // 운영체제마다 dir seperator 문자가 다르다
    // 어떤 운영체제는 슬래시(/)를 사용하고
    // 어떤 운영체제는 역슬래시(\)를 사용한다
    // "폴더1" + "/" + "폴더2" + "/" + "폴더3"
    // "폴더1" + "\" + "폴더2" + "\" + "폴더3"
    //
    // 이때 path.join() 이라는 함수를 사용하여 폴더를 결합하면
    // 자동으로 운영체제에 맞는 구분자(dir seperator)를 만들어 준다
    String dbFile = join(dbPath, "todo.dbf");

    return await openDatabase(
      dbFile,
      onCreate: onCreateTable,
      onUpgrade: onUpgradeTable,
      version: 2,
    );
  }

  // DB를 사용할수 있도록 open 하고 연결정보가 담긴 _database 변수를 초기화 한다
  // flutter 에서 사용하는 다소 특이한 getter method
  // 이 함수는 () 가 없고, 함수 이름앞에 get 키워드가 있다
  // 이 함수이름과 연관된 로컬변수 _함수 와 같은 형식의 변수가 있어야 한다.
  Future<Database> get database async {
    _database = await initDatabase();
    return _database;
  }

  insert(Todo todo) async {
    final db = await database;
    debugPrint("INSERT TO : ${todo.toString()}");
    var result = await db.insert(
      TBL_TODO,
      todo.toMap(),
    );
  }

  // Future 동적데이터에 대한 약속
  // selectAll() 함수를 호출하면 반드시 List<Todo> 데이터 타입을 return 하겠다
  Future<List<Todo>> selectAll() async {
    final db = await database;
    // final todoList = await db.query((TBL_TODO));
    final List<Map<String, dynamic>> todoList = await db.query(TBL_TODO);
    final result = List.generate(
      todoList.length,
      (index) => Todo.fromMap(todoList[index]),
    );
    return result;
  }
}
