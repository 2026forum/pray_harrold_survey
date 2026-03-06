import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Person {
  final String uid;
  final String username;
  final List<String> selectedPosts;
  final String? email;
  final String? biography;
  final int colorCode1;
  final int colorCode2; 
  Person({
    required this.uid,
    required this.username,
    required this.selectedPosts,
    this.email,
    this.biography,
    required this.colorCode1,
    required this.colorCode2,
  });


  int get _shade => 40; 

  Color get proColor => Color(colorCode1);
  Color get conColor => Color(colorCode2);
  Color get shadedProColor => proColor.withAlpha(_shade);
  Color get shadedConColor => conColor.withAlpha(_shade);

  Person copyWith({
    String? uid,
    String? username,
    List<String>? selectedPosts,
    ValueGetter<String?>? email,
    ValueGetter<String?>? biography,
    int? colorCode1,
    int? colorCode2,
  }) {
    return Person(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      selectedPosts: selectedPosts ?? this.selectedPosts,
      email: email != null ? email() : this.email,
      biography: biography != null ? biography() : this.biography,
      colorCode1: colorCode1 ?? this.colorCode1,
      colorCode2: colorCode2 ?? this.colorCode2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'selectedPosts': selectedPosts,
      'email': email,
      'biography': biography,
      'colorCode1': colorCode1,
      'colorCode2': colorCode2,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      selectedPosts: List<String>.from(map['selectedPosts']),
      email: map['email'],
      biography: map['biography'],
      colorCode1: map['colorCode1']?.toInt() ?? 0,
      colorCode2: map['colorCode2']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(uid: $uid, username: $username, selectedPosts: $selectedPosts, email: $email, biography: $biography, colorCode1: $colorCode1, colorCode2: $colorCode2)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Person &&
      other.uid == uid &&
      other.username == username &&
      listEquals(other.selectedPosts, selectedPosts) &&
      other.email == email &&
      other.biography == biography &&
      other.colorCode1 == colorCode1 &&
      other.colorCode2 == colorCode2;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      username.hashCode ^
      selectedPosts.hashCode ^
      email.hashCode ^
      biography.hashCode ^
      colorCode1.hashCode ^
      colorCode2.hashCode;
  }
}
