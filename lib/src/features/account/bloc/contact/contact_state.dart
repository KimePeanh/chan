import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/features/account/models/contact.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

// ignore: must_be_immutable
abstract class ContactState extends Equatable {
  ContactState() : super();
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchingContact extends ContactState {
  FetchingContact();
}

// ignore: must_be_immutable
class FetchedContact extends ContactState {
  final Contact contact;
  FetchedContact({required this.contact});
}

// ignore: must_be_immutable
class ErrorFetchingContact extends ContactState with ErrorState {
  final dynamic error;
  ErrorFetchingContact({required this.error});
}
