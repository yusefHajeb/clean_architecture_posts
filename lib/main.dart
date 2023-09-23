import 'package:clean_architecture_posts/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'enjection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/page/post_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (context) => di.sl<AddUpdateDeletePostBloc>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Posts App',
          theme: appTheme,
          home: PostPage()),
    );
  }
}

// class HomeBage extends StatelessWidget {
//   const HomeBage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
