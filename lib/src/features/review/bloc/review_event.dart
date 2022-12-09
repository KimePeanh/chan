import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  @override
  List<Object> get props => [];
  ReviewEvent();
}

class InitializeReviewList extends ReviewEvent {
  final arg;
  InitializeReviewList({this.arg});
}

class FetchReviewList extends ReviewEvent {
  final arg;
  FetchReviewList({required this.arg});
}

class AddReview extends ReviewEvent {
  final String productId;
  final double star;
  final String comment;
  AddReview(
      {required this.productId, required this.star, required this.comment});
}

class UpdateReview extends ReviewEvent {
  final String reviewId;
  final double star;
  final String comment;
  UpdateReview(
      {required this.reviewId, required this.star, required this.comment});
}
