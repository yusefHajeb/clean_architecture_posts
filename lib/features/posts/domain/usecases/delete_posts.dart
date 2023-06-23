import 'package:clean_architecture_posts/core/error/failure.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deletePost(id);
  }
}
