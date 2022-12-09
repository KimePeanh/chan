import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_quality_event.dart';

class ImageQualityBloc extends Bloc<ImageQualityEvent, FilterQuality> {
  ImageQualityBloc() : super(FilterQuality.medium);
  @override
  Stream<FilterQuality> mapEventToState(ImageQualityEvent event) async* {
    if (event is InitializeStarted) {
      yield FilterQuality.medium;
    }
    if (event is QualityChoosen) {
      yield event.filterQuality;
    }
  }
}
