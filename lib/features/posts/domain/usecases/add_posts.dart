import 'package:clean_architecture_posts/core/error/failure.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../entites/post.dart';

class AddPostUseCase {
  final PostsRepository repository;

  AddPostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
