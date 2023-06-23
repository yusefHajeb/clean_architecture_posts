import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts/core/error/expintion.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/string/failures.dart';
import '../../../../../core/string/messages.dart';
import '../../../domain/entites/post.dart';
import '../../../domain/usecases/add_posts.dart';
import '../../../domain/usecases/delete_posts.dart';
import '../../../domain/usecases/update_posts.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  AddUpdateDeletePostBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeleteState());
        final failureOrSuccessMsg = await addPost(event.post);
        emit(_eitherSuccessOrFailure(failureOrSuccessMsg, addSuccessMessage));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeleteState());
        final failureOrSuccessMsg = await updatePost(event.post);
        emit(
            _eitherSuccessOrFailure(failureOrSuccessMsg, updateSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeleteState());
        final failureOrSuccessMsg = await deletePost(event.postId);
        emit(
            _eitherSuccessOrFailure(failureOrSuccessMsg, deleteSuccessMessage));
      }
    });
  }

  AddUpdateDeletePostState _eitherSuccessOrFailure(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) =>
          ErrorAddUpdateDeleteState(errorMsg: _failureToMessage(failure)),
      (_) => SuccessAddUpdateDeleteState(message: message),
    );
  }

  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerExpinton:
        return serverFailureMessage;
      case OffLineExpention:
        return offlineFailureMessage;
      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}
