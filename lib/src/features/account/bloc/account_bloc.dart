import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/account/models/user.dart';
import 'package:lady_skin/src/features/account/bloc/account_event.dart';
import 'package:lady_skin/src/features/account/repositories/account_repository.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountRepository _accountRepository = AccountRepository();
  @override
  AccountBloc() : super(FetchingAccount());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is FetchAccountStarted) {
      yield FetchingAccount();
      try {
        final User _user = await _accountRepository.getAccount();
        yield FetchedAccount(user: _user);
      } catch (e) {
        yield ErrorFetchingAccount(error: e);
      }
    }
    if (event is SetAccount) {
      yield FetchingAccount();
      yield FetchedAccount(user: event.user);
    }
    if (event is UpdateAccount) {
      yield UpdatingAccount();
      try {
        final String imageUrl = await uploadImage(image: event.imageFile!);
        print(imageUrl);
        event.user.profileImage = imageUrl;
        await _accountRepository.updateAccount(event.user);
        yield UpdatedAccount();
      } catch (e) {
        print(e.toString());
        yield ErrorUpdatingAccount(error: e);
      }
    }
  }
}
