import 'dart:convert';

class Comment {
  final String commentText;
  final String author;
  final String authorId; 
  Comment({
    required this.commentText,
    required this.author,
    required this.authorId,
  });
 

  Comment copyWith({
    String? commentText,
    String? author,
    String? authorId,
  }) {
    return Comment(
      commentText: commentText ?? this.commentText,
      author: author ?? this.author,
      authorId: authorId ?? this.authorId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentText': commentText,
      'author': author,
      'authorId': authorId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      commentText: map['commentText'] ?? '',
      author: map['author'] ?? '',
      authorId: map['authorId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));

  @override
  String toString() => 'Comment(commentText: $commentText, author: $author, authorId: $authorId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Comment &&
      other.commentText == commentText &&
      other.author == author &&
      other.authorId == authorId;
  }

  @override
  int get hashCode => commentText.hashCode ^ author.hashCode ^ authorId.hashCode;
}
