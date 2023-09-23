import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../domain/entites/post.dart';
import '../../page/post_ditel_page.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, i) {
          return ListTile(
            focusColor: Colors.grey[400],
            style: ListTileStyle.list,
            leading: Text(posts[i].id.toString()),
            title: Text(
              posts[i].title.toString(),
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
            ),
            subtitle: Text(
              posts[i].body,
              style: Theme.of(context).textTheme.headline2,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PostDitlePage(
                            post: posts[i],
                          )));
            },
          );
        },
        separatorBuilder: (context, i) {
          return Divider(
            thickness: 1,
          );
        },
        itemCount: posts.length);
  }
}
