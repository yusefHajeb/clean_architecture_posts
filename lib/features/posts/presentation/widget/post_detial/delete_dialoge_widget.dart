import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/page/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogeWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogeWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        ' Are you Sure ? ',
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No")),
        TextButton(
            onPressed: () {
              BlocProvider.of<AddUpdateDeletePostBloc>(context)
                  .add(DeletePostEvent(postId: postId));
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PostPage()));
            },
            child: Text("Yes")),
      ],
    );
  }
}
