import 'package:equatable/equatable.dart';

// all failure يقابله expintion why?
// whole error expentio we are throw expentopn to class
//
abstract class Failure extends Equatable {}

class OffLineFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmptyCasheFailure extends Failure {
  List<Object?> get props => [];
}
