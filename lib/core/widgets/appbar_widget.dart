import 'package:clean_architecture_posts/core/color/appcolor.dart';
import 'package:flutter/material.dart';

class ApppBarWidget extends StatelessWidget {
  final String title;
  const ApppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: AppColor.secanderyColor),
      ),
      backgroundColor: AppColor.iconsColor,
    );
  }
}
