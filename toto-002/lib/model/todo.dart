// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  String id;
  String sdate;
  String stime;
  String edate;
  String etime;
  String content;
  bool complete;
  Todo({
    required this.id,
    required this.sdate,
    required this.stime,
    required this.edate,
    required this.etime,
    required this.content,
    required this.complete,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sdate': sdate,
      'stime': stime,
      'edate': edate,
      'etime': etime,
      'content': content,
      'complete': complete,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      sdate: map['sdate'] as String,
      stime: map['stime'] as String,
      edate: map['edate'] as String,
      etime: map['etime'] as String,
      content: map['content'] as String,
      complete: map['complete'] as bool,
    );
  }
  String toJson() => json.encode(toMap());
  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(id: $id, sdate: $sdate, stime: $stime, edate: $edate, etime: $etime, content: $content, complete: $complete)';
  }
}
