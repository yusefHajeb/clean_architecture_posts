import 'package:dartz/dartz.dart';
import '../../../../core/error/expintion.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/networkconective.dart';
import '../../domain/entites/post.dart';
import '../../domain/repositories/post_repositories.dart';

import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../models/post_model.dart';

typedef AddOrUpdateOrDeltePost = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final List<PostModel> remotePosts =
            await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerExpinton {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<PostModel> localPosts =
            await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCasheExpention {
        return Left(EmptyCasheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() => remoteDataSource.updatePost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() => remoteDataSource.deletePost(postId));
  }

  Future<Either<Failure, Unit>> _getMessage(
      AddOrUpdateOrDeltePost addOrUpdateOrDeletePost) async {
    if (await networkInfo.isConnected) {
      try {
        addOrUpdateOrDeletePost;
        return const Right(unit);
      } on ServerExpinton {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
