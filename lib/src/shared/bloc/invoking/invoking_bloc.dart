import 'package:bloc/bloc.dart';
import 'invoking_state.dart';

enum InvokingEvent { Invoke, Sleep }

class InvokingBloc extends Bloc<InvokingEvent, InvokingState> {
  bool isInvoked = false;
  InvokingBloc() : super(Sleeping());

  @override
  Stream<InvokingState> mapEventToState(InvokingEvent event) async* {
    switch (event) {
      case InvokingEvent.Invoke:
        yield Invoked();
        isInvoked = true;
        break;
      case InvokingEvent.Sleep:
        yield Sleeping();
        break;
    }
  }
}
