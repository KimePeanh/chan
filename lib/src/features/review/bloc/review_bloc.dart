import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/review/models/review.dart';
import 'package:lady_skin/src/features/review/repositories/review_list_repository.dart';
import 'package:lady_skin/src/features/review/repositories/review_repostitory.dart';

import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc({required this.reviewListRepository, this.rowPerPage = 10})
      : super(InitializingReviewList());

  final ReviewListRepository reviewListRepository;
  final ReviewRepository reviewRepository = ReviewRepository();
  int page = 1;
  List<Review> reviewList = [];
  int rowPerPage = 10;
  Review? myReview;
  Map? reviewContent;
  String canAdd = "false";
  @override
  Stream<ReviewState> mapEventToState(ReviewEvent event) async* {
    if (event is InitializeReviewList) {
      yield InitializingReviewList();
      try {
        page = 1;
        reviewContent = await reviewListRepository.getReviewList(
            page: page, rowPerPage: rowPerPage, additionalArg: event.arg);
        canAdd = reviewContent!["can_add"];
        myReview = reviewContent!["my_review"];
        reviewList = reviewContent!["review_list"];
        page++;
        yield InitializedReviewList();
      } catch (e) {
        yield ErrorInitializingReviewList(error: e);
      }
    }
    if (event is FetchReviewList) {
      yield FetchingReviewList();
      try {
        reviewContent = await reviewListRepository.getReviewList(
            page: page, rowPerPage: rowPerPage, additionalArg: event.arg);
        reviewList.addAll(reviewContent!["review_list"]);
        page++;
        if (reviewContent!["review_list"].length < rowPerPage) {
          yield EndOfReviewList();
        } else {
          yield FetchedReviewList();
        }
      } catch (e) {
        yield ErrorInitializingReviewList(error: e);
      }
    }
    if (event is AddReview) {
      yield AddingReview();
      try {
        await reviewRepository.addReview(
            productId: event.productId,
            star: event.star,
            comment: event.comment);
        yield AddedReview();
      } catch (e) {
        yield ErrorAddingReview(error: e);
      }
    }
    if (event is UpdateReview) {
      yield UpdatingReview();
      try {
        await reviewRepository.updateReview(
            reviewId: event.reviewId, star: event.star, comment: event.comment);
        yield UpdatedReview();
      } catch (e) {
        yield ErrorUpdateReview(error: e);
      }
    }
  }
}
