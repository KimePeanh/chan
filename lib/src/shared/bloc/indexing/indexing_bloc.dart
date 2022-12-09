import 'package:flutter_bloc/flutter_bloc.dart';

import 'indexing_event.dart';

class IndexingBloc extends Bloc<IndexingEvent, int> {
  @override
  IndexingBloc() : super(0);

  @override
  Stream<int> mapEventToState(IndexingEvent event) async* {
    if (event is Taped) {
      yield event.index;
    }
  }
}

IndexingBloc categoryIndexBloc = IndexingBloc();
