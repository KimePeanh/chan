import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/account/models/contact.dart';
import 'package:lady_skin/src/features/account/repositories/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactRepository _contactRepository = ContactRepository();
  @override
  ContactBloc() : super(FetchingContact());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is FetchContact) {
      yield FetchingContact();
      try {
        final Contact contact = await _contactRepository.getContact();
        yield FetchedContact(contact: contact);
      } catch (e) {
        yield ErrorFetchingContact(error: e);
      }
    }
  }
}
