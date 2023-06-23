// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../entites/post.dart';

import '../repositories/post_repositories.dart';

class GetAllPostsUseCase {
  final PostsRepository repository;
  GetAllPostsUseCase({
    required this.repository,
  });
  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
