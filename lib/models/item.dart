import 'dart:convert';

import 'package:flutter/foundation.dart';

class Item {
   final String name;
  final List<String> agreement;
  final List<String> disagreement;
  Item({
    required this.name,
    required this.agreement,
    required this.disagreement,
  });


    int get score {
    return (agreement.length - disagreement.length);
  }

  String get scoreStr {
    return score.toString();
  }

  String get id {
    return name.toLowerCase();
  }

  Item copyWith({
    String? name,
    List<String>? agreement,
    List<String>? disagreement,
  }) {
    return Item(
      name: name ?? this.name,
      agreement: agreement ?? this.agreement,
      disagreement: disagreement ?? this.disagreement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'agreement': agreement,
      'disagreement': disagreement,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'] ?? '',
      agreement: List<String>.from(map['agreement']),
      disagreement: List<String>.from(map['disagreement']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() => 'Item(name: $name, agreement: $agreement, disagreement: $disagreement)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Item &&
      other.name == name &&
      listEquals(other.agreement, agreement) &&
      listEquals(other.disagreement, disagreement);
  }

  @override
  int get hashCode => name.hashCode ^ agreement.hashCode ^ disagreement.hashCode;
}
