import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class Initializing extends ProductState {}

class FetchingProduct extends ProductState {}

class FetchedProduct extends ProductState {}

class ErrorFetchingProduct extends ProductState {
  final String error;
  ErrorFetchingProduct({required this.error});
}
