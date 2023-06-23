// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_posts/core/error/expintion.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const String baseUrl = "https://jsonplaceholder.typicode.com";

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("$baseUrl/posts/"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List decodedJson = jsonDecode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map((jsonPostModel) => PostModel.fromMap(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerExpinton();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final requestBody = {
      PostModelFields.title: postModel.title,
      PostModelFields.body: postModel.body,
    };
    final response = await client.post(
      Uri.parse("$baseUrl/posts/"),
      body: requestBody,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerExpinton();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id;
    final requestBody = {
      PostModelFields.title: postModel.title,
      PostModelFields.body: postModel.body,
    };
    final response = await client.patch(
      Uri.parse("$baseUrl/posts/$postId"),
      body: requestBody,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExpinton();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await client.delete(
      Uri.parse("$baseUrl/posts/$id"),
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExpinton();
    }
  }
}
