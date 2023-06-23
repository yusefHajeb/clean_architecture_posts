import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts/core/error/failure.dart';
import 'package:clean_architecture_posts/features/posts/domain/entites/post.dart';
import '../../../../../core/string/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        failureOrPosts.fold(
          (failure) {
            emit(ErrorPostsState(errorMsg: _failureToMessage(failure)));
          },
          (posts) {
            emit(LoadedPostsState(posts: posts));
          },
        );
        // emit(_failureOrPostToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_failureOrPostToState(failureOrPosts));
      }
    });
  }

  PostsState _failureOrPostToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(errorMsg: _failureToMessage(failure)),
      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCashExpention:
        return emptyCacheFailureMessage;
      case OffLineFailure:
        return offlineFailureMessage;
      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}
