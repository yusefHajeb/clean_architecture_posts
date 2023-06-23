import 'dart:convert';

// import '../../../../core/error/exceptions.dart';
import 'package:clean_architecture_posts/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> mostModels);
}

const String CACHED_POSTS = "CACHED_POSTS";

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toMap())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, jsonEncode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonPosts = sharedPreferences.getString(CACHED_POSTS);
    if (jsonPosts != null) {
      List decodeJsonPosts = jsonDecode(jsonPosts);
      List<PostModel> jsonToPostModels = decodeJsonPosts
          .map<PostModel>((decodeJsonPost) => PostModel.fromMap(decodeJsonPost))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCashExpention();
    }
  }
}
