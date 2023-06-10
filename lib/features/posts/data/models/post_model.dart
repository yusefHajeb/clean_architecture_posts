import 'package:clean_architecture_posts/features/posts/domain/entites/post.dart';
import 'package:flutter/foundation.dart';

class PostModel extends Post {
  PostModel({required super.id, required super.title, required super.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, "title": title, "body": body};
  }
}
