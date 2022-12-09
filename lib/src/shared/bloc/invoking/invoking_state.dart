import 'package:equatable/equatable.dart';

abstract class InvokingState extends Equatable {
  //const InvokingState();
  @override
  List<Object> get props => [];
}

class Sleeping extends InvokingState {
  @override
  String toString() {
    return "Sleeping";
  }
}

class Invoked extends InvokingState {
  @override
  String toString() {
    return "Invoked";
  }
}
