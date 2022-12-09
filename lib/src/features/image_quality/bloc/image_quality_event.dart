import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ImageQualityEvent extends Equatable {
  ImageQualityEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class InitializeStarted extends ImageQualityEvent {}

class QualityChoosen extends ImageQualityEvent {
  final FilterQuality filterQuality;
  QualityChoosen({required this.filterQuality});
}
