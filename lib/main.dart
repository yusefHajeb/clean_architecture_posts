import 'package:clean_architecture_posts/core/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Posts app'),
        ),
        body: const Center(
          child: Text('Posts'),
        ),
      ),
    );
  }
}

class HomeBage extends StatelessWidget {
  const HomeBage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
