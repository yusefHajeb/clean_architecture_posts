// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<Post> posts;
  const LoadedPostsState({
    required this.posts,
  });

  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String errorMsg;
  const ErrorPostsState({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];
}
