// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddUpdateDeleteState extends AddUpdateDeletePostState {}

class SuccessAddUpdateDeleteState extends AddUpdateDeletePostState {
  final String message;
  const SuccessAddUpdateDeleteState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ErrorAddUpdateDeleteState extends AddUpdateDeletePostState {
  final String errorMsg;
  const ErrorAddUpdateDeleteState({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];
}
