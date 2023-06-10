import 'package:clean_architecture_posts/core/network/networkconective.dart';
import 'package:clean_architecture_posts/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture_posts/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_posts/features/posts/data/models/post_model.dart';
import 'package:clean_architecture_posts/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts/core/error/failure.dart';
import 'package:clean_architecture_posts/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

typedef Future<Unit> DeleteOrAddOrUpdatePosts();

class PostsRepositoryImp implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostsRepositoryImp(this.networkInfo,
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    //check internet to get form api or Local data source
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on OffLineFailure {
        return Left(OffLineFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) {
    return _getMessage(() {
      return remoteDataSource.deletePost(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrAddOrUpdatePosts deleteOrAddOrUpdatePosts) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrAddOrUpdatePosts;
        return const Right(unit);
      } on ServerFailure {
        return left(ServerFailure());
      }
    } else {
      return left(OffLineFailure());
    }
  }
}
