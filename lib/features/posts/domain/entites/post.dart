import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  fromJson(Map<String, dynamic> json) {}
  Post({required this.id, required this.title, required this.body});
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, body];
}
