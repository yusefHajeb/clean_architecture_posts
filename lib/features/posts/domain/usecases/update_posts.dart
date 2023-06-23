// import post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entites/post.dart';
import '../repositories/post_repositories.dart';

class UpdatePostUseCase {
  final PostsRepository repository;
  UpdatePostUseCase({required this.repository});
  Future<Either<Failure, Unit>> call(Post post) async {
    return repository.updatePost(post);
  }
}
