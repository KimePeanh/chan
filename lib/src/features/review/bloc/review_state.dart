import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class InitializingReviewList extends ReviewState {}

class InitializedReviewList extends ReviewState {}

class FetchingReviewList extends ReviewState {}

class FetchedReviewList extends ReviewState {}

class EndOfReviewList extends ReviewState {}

class ErrorFetchingReviewList extends ReviewState with ErrorState {
  final dynamic error;
  ErrorFetchingReviewList({required this.error});
}

class ErrorInitializingReviewList extends ReviewState with ErrorState {
  final dynamic error;
  ErrorInitializingReviewList({required this.error});
}

class RegisteringShop extends ReviewState {}

class RegisteredShop extends ReviewState {}

class ErrorRegisterShop extends ReviewState with ErrorState {
  final dynamic error;
  ErrorRegisterShop({required this.error});
}

class AddingReview extends ReviewState {}

class AddedReview extends ReviewState {}

class ErrorAddingReview extends ReviewState with ErrorState {
  final dynamic error;
  ErrorAddingReview({required this.error});
}

class UpdatingReview extends ReviewState {}

class UpdatedReview extends ReviewState {}

class ErrorUpdateReview extends ReviewState with ErrorState {
  final dynamic error;
  ErrorUpdateReview({required this.error});
}
