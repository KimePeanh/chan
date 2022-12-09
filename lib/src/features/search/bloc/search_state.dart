import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class Initializing extends SearchState {}

class Searching extends SearchState {
  final bool isInitiallySearch;
  Searching({this.isInitiallySearch = true});
}

class Searched extends SearchState {}

class FetchedHistory extends SearchState {
  final List<String> history;
  FetchedHistory({required this.history});
}

class ErrorSearching extends SearchState {
  final String error;
  ErrorSearching({required this.error});
}
