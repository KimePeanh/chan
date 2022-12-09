import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget productTileSkeleton() => Container(
      color: Colors.white,
      child: Column(
        children: [
          Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: AspectRatio(
                aspectRatio: 4 / 4,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
              )),
          Expanded(
              flex: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Center(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )),
        ],
      ),
    );
