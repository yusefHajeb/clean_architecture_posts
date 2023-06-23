import 'package:clean_architecture_posts/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architecture_posts/features/posts/presentation/widget/post_add_update_widget/text_from_file.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  GlobalKey _key = GlobalKey<FormState>();
  TextEditingController _texttitlePost = TextEditingController();
  TextEditingController _textBodyPost = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdatePost) {
      _texttitlePost.text = widget.post!.title.toString();
      _textBodyPost.text = widget.post!.body.toString();
    }

    _key = GlobalKey<FormState>();

    // TODO: implement initState
    super.initState();
  }

  void validateFormtThenAupdateOrAdd() {
    final valid = _key.currentWidget;
    final postModel = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _texttitlePost.text,
        body: _textBodyPost.text);

    if (widget.isUpdatePost) {
      BlocProvider.of<AddUpdateDeletePostBloc>(context)
          .add(UpdatePostEvent(post: postModel));
    } else {
      BlocProvider.of<AddUpdateDeletePostBloc>(context)
          .add(AddPostEvent(post: postModel));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFileWidget(controller: _texttitlePost, name: "title"),
            SizedBox(
              height: 50,
            ),
            TextFormFileWidget(
              controller: _textBodyPost,
              name: "body",
            ),
            MaterialButton(
              onPressed: validateFormtThenAupdateOrAdd,
              child: Row(
                children: [
                  Icon(Icons.edit),
                  Text(widget.isUpdatePost ? "Update" : "Add")
                ],
              ),
            )
          ],
        ));
  }
}
