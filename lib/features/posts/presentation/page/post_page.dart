import 'dart:convert';
import 'dart:ui';

import 'package:clean_architecture_posts/core/color/appcolor.dart';
import 'package:clean_architecture_posts/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/page/post_add_update.dart';
import 'package:clean_architecture_posts/features/posts/presentation/page/post_ditel_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../core/widgets/loading_widget.dart';
import '../widget/post_page_widget/message_display_widget.dart';
import '../widget/post_page_widget/post_list_widget.dart';

class PostPage extends StatelessWidget {
  const PostPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildingFloatingBtn(
        context,
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text(
          "Posts",
          style: TextStyle(color: AppColor.secanderyColor),
        ),
        backgroundColor: AppColor.iconsColor,
      );
  // getData() async {
  //   var response = await http.post(
  //     Uri.parse("http://172.18.48.1:8012/ecommerce/test.php"),
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print("you in Curd ===============");
  //     Map responsebody = jsonDecode(response.body);
  //     print(response.body);
  //   }
  //   print(" ===============");
  // }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return LoadingWidget();
        } else if (state is ErrorPostsState) {
          return MessageDisplayWidget(
            message: state.errorMsg,
          );
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
              onRefresh: () => _onRefreshIndicator(context),
              child: InkWell(
                onTap: () {},
                child: PostListWidget(
                  posts: state.posts,
                ),
              ));
        }

        return LoadingWidget();
      }),
    );
  }

  Future<void> _onRefreshIndicator(BuildContext ctx) async {
    // add is function to import Bloc
    //
    BlocProvider.of<PostsBloc>(ctx).add(RefreshPostsEvent());
  }

  Widget _buildingFloatingBtn(BuildContext ctx) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(ctx).push(MaterialPageRoute(
            builder: (_) => PostAddUpdate(
                  isUpdate: false,
                )));
      },
      backgroundColor: AppColor.iconsColor,
      child: Icon(
        Icons.add,
        color: AppColor.backgroundColor,
      ),
    );
  }
}
