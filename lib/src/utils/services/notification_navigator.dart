import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lady_skin/src/features/blog/screens/blog_detail_page.dart';
import 'package:lady_skin/src/features/blog/screens/widgets/blog_list_by_category.dart';
import 'package:lady_skin/src/features/product/screens/product_detail_page.dart';
import 'package:lady_skin/src/features/product/screens/product_list_by_category_page.dart';

notificationNavigator(BuildContext context,
    {required String? target, required String? targetValue}) {
  log("$target $targetValue");
  if (target != null && targetValue != null) {
    switch (target.toLowerCase()) {
      case "products":
        print("products");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ProductDetailPageWrapper(
                      productOrId: targetValue,
                    )));
        break;
      case "categories":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ProductListByCategoryPageWrapper(
                      categoryOrId: targetValue,
                    )));
        break;
      case "blogs":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => BlogDetailPageWrapper(blogOrId: targetValue)));
        break;
      case "blog_categories":
        print("blog_categories");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => BlogListByCategoryWrapper(
                      blogCategoryOrId: targetValue,
                    )));
        break;
      default:
        break;
    }
  }
}
