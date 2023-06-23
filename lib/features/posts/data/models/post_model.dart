import 'dart:convert';

import 'package:clean_architecture_posts/features/posts/domain/entites/post.dart';

class PostModel extends Post {
  PostModel({
    int? super.id,
    required super.title,
    required super.body,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PostModelFields.id: id,
      PostModelFields.title: title,
      PostModelFields.body: body,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map[PostModelFields.id] as int,
      title: map[PostModelFields.title] as String,
      body: map[PostModelFields.body] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PostModelFields {
  static const String id = "id";
  static const String title = "title";
  static const String body = "body";
}
