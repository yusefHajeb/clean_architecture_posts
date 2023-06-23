import 'package:flutter/material.dart';

class TextFormFileWidget extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final int? minLine;
  const TextFormFileWidget(
      {super.key, required this.controller, required this.name, this.minLine});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (val) => val!.isEmpty ? "$name Can/'t be empty" : null,
      decoration: InputDecoration(
        hintText: "Title",
        border: InputBorder.none,
      ),
      minLines: minLine != null ? 6 : 1,
    );
  }
}
