import 'package:clean_architecture_posts/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/page/post_add_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/color/appcolor.dart';
import '../../../../core/utel/message_snackbar.dart';
import '../widget/post_detial/delete_dialoge_widget.dart';

class PostDitlePage extends StatelessWidget {
  final Post post;
  const PostDitlePage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, post),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Post Edite",
        style: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: AppColor.iconsColor,
    );
  }

  Widget _buildBody(BuildContext context, Post post) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Text(
          "Show Posts",
          style: Theme.of(context).textTheme.headline2,
        ),
        Divider(
          height: 50,
        ),
        Text(
          post.body,
          style: Theme.of(context).textTheme.headline2,
        ),
        Divider(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PostAddUpdate(
                              isUpdate: true,
                              post: post,
                            )));
              },
              icon: Icon(Icons.add_chart_sharp),
              label: Text("updage"),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColor.iconsColor)),
            ),
            ElevatedButton.icon(
              onPressed: () => deleteDialoge(context),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              icon: Icon(Icons.add_chart_sharp),
              label: Text("delete"),
            ),
          ],
        )
      ]),
    );
  }

  void deleteDialoge(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is SuccessAddUpdateDeleteState) {
              MessageSnackBar().showSuccessSnackBar(
                  message: state.message, context: context);
            } else if (state is ErrorAddUpdateDeleteState) {
              MessageSnackBar()
                  .showErrorSnackBar(message: state.errorMsg, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogeWidget(postId: post.id!);
          },
        );
      },
    );
  }
}
