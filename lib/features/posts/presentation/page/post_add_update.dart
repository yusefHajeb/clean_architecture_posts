// import 'dart:html';
// import 'dart:js';

import 'package:clean_architecture_posts/core/utel/message_snackbar.dart';
import 'package:clean_architecture_posts/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/widget/post_add_update_widget/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entites/post.dart';
import 'post_page.dart';

class PostAddUpdate extends StatelessWidget {
  final bool isUpdate;
  final Post? post;
  const PostAddUpdate({required this.isUpdate, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext ctx) {
    return AppBar(
      title: Text(isUpdate ? "Upadate Post" : " Add Post"),
    );
  }

  Widget _buildBody(BuildContext ctx) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          builder: (context, state) {
            if (state is LoadingAddUpdateDeleteState) {
              return LoadingWidget();
            }
            return FormWidget(
              isUpdatePost: isUpdate,
              post: isUpdate ? post : null,
            );
          },
          listener: (context, state) {
            if (state is SuccessAddUpdateDeleteState) {
              MessageSnackBar().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => PostPage()),
                  (route) => false);
            } else if (state is ErrorAddUpdateDeleteState) {
              MessageSnackBar()
                  .showErrorSnackBar(message: state.errorMsg, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => PostPage()),
                  (route) => false);
            }
          },
        ),
      ),
    );
  }
}
