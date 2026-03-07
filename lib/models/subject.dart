class Subject {
  final String subjectId;
  final String title;
  final List<String> agreement;
  final List<String> disagreement;
  Subject({required this.subjectId, required this.title, required this.agreement, required this.disagreement});

  int get score {
    return (agreement.length - disagreement.length);
  }

  String get scoreStr {
    return score.toString();
  }

  Subject copyWith({String? subjectId, String? title, List<String>? agreement, List<String>? disagreement}) {
    return Subject(
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      agreement: agreement ?? this.agreement,
      disagreement: disagreement ?? this.disagreement,
    );
  }

  Map<String, dynamic> toMap() {
    return {'subjectId': subjectId, 'title': title, 'agreement': agreement, 'disagreement': disagreement};
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      subjectId: map['subjectId'] ?? '',
      title: map['title'] ?? '',
      agreement: List<String>.from(map['agreement']),
      disagreement: List<String>.from(map['disagreement']),
    );
  }
}
