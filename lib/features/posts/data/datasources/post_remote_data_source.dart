import 'dart:convert';

import 'package:clean_architecture_posts/core/error/expintion.dart';
import 'package:clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const String baseUrl = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImp implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImp({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("$baseUrl/posts/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final decodeJson = json.decode(response.body);
      final List<PostModel> postModels = decodeJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerExpinton();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response = await client.post(Uri.parse("$baseUrl/post/"), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExpinton();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response =
        await client.delete(Uri.parse("$baseUrl/posts/${postId.toString()}"));

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExpinton();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.patch(Uri.parse("$baseUrl/posts/"), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExpinton();
    }
  }
}
