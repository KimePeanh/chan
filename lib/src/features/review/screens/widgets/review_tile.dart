import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lady_skin/src/features/review/models/review.dart';

Widget reviewTile(Review review, {bool currentUserReviewed = false}) {
  return Container(
    margin: EdgeInsets.only(bottom: 25, left: 15, right: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: const EdgeInsets.only(right: 0, top: 0, bottom: 0),
                width: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.person_outline)),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    (currentUserReviewed) ? "You" : review.reviewer,
                    textScaleFactor: 1.2,
                  ),
                  SizedBox(height: 5),
                  RatingBar.builder(
                    itemPadding: EdgeInsets.all(0),
                    itemSize: 20,
                    unratedColor: Colors.grey[300],
                    ignoreGestures: true,
                    initialRating: double.parse(review.star),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            ),
          ]),
        ),
        SizedBox(height: 10),
        Text(
          review.comment == null ? "" : review.comment!,
          textScaleFactor: 0.9,
        )
      ],
    ),
  );
}
