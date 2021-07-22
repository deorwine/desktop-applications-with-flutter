import 'package:localstore/localstore.dart';

/// Data Model
class Todo {
  final String id;
  String name;
  String email;
  String mobile;
  String imagePath;
  Todo({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'imagePath': imagePath,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      mobile: map['mobile'],
      imagePath: map['imagePath'],
    );
  }
}

extension ExtTodo on Todo {
  Future save() async {
    final _db = Localstore.instance;
    return _db.collection('paras').doc(id).set(toMap());
  }

  Future delete() async {
    final _db = Localstore.instance;
    return _db.collection('paras').doc(id).delete();
  }
}
