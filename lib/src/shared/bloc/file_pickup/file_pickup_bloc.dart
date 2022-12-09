import 'package:flutter_bloc/flutter_bloc.dart';

class FilePickupBloc extends Bloc<dynamic, dynamic> {
  @override
  FilePickupBloc() : super(null);

  @override
  Stream<dynamic> mapEventToState(dynamic event) async* {
    yield event;
  }
}
