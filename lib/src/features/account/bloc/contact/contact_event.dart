import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  ContactEvent() : super();
  @override
  List<Object> get props => [];
}

class FetchContact extends ContactEvent {
  FetchContact();
}
