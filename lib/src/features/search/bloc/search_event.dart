import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class SearchStarted extends SearchEvent {
  final String query;
  final bool isauth;

  SearchStarted({required this.query, required this.isauth});
}

class FetchHistory extends SearchEvent {}
