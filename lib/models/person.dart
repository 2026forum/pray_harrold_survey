import 'package:flutter/material.dart';

class Person {
  final String uid;
  final String username;
  final String? email;

  final int colorCode1;
  final int colorCode2;
  Person({required this.uid, required this.username, this.email, required this.colorCode1, required this.colorCode2});

  int get _shade => 40;

  Color get proColor => Color(colorCode1);
  Color get conColor => Color(colorCode2);
  Color get shadedProColor => proColor.withAlpha(_shade);
  Color get shadedConColor => conColor.withAlpha(_shade);

  Person copyWith({String? uid, String? username, ValueGetter<String?>? email, int? colorCode1, int? colorCode2}) {
    return Person(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email != null ? email() : this.email,
      colorCode1: colorCode1 ?? this.colorCode1,
      colorCode2: colorCode2 ?? this.colorCode2,
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'username': username, 'email': email, 'colorCode1': colorCode1, 'colorCode2': colorCode2};
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'],
      colorCode1: map['colorCode1']?.toInt() ?? 0,
      colorCode2: map['colorCode2']?.toInt() ?? 0,
    );
  }
}
