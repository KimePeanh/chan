import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/category/models/category.dart';
import 'package:lady_skin/src/features/login_register/repositories/login_register_repository.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  late List<Category> category;
  LoginRegisterRepository _loginRegisterRepository = LoginRegisterRepository();
  @override
  RegisterBloc() : super(Initializing());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterPressed) {
      yield Registering();
      try {
        String _phoneNummber =
            Helper.convertToKhmerPhoneNumber(number: event.phoneNumber);
        final String _token = await _loginRegisterRepository.register(
            name: event.name, phone: _phoneNummber, password: event.password);
        yield Registered(token: _token);
      } catch (e) {
        yield ErrorRegistering(error: e.toString());
      }
    }
  }
}
