import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lady_skin/src/features/buy_now/models/buy_now_item.dart';
import 'package:lady_skin/src/features/buy_now/screens/buy_now_page.dart';
import 'package:lady_skin/src/features/cart/screens/cart_page.dart';
import 'package:lady_skin/src/features/category/models/category.dart';
import 'package:lady_skin/src/features/change_password/screens/change_password_page.dart';
import 'package:lady_skin/src/features/checkout/screens/checkout_page.dart';
import 'package:lady_skin/src/features/checkout/screens/checkout_status_page.dart';
import 'package:lady_skin/src/features/favourite/screens/favourite_page.dart';
import 'package:lady_skin/src/features/feedback/screens/feedback_page.dart';
import 'package:lady_skin/src/features/image_quality/screens/image_quality_page.dart';
import 'package:lady_skin/src/features/login_register/screens/login_register_page.dart';
import 'package:lady_skin/src/features/my_order/models/my_order.dart';
import 'package:lady_skin/src/features/my_order/screens/my_order_page.dart';
import 'package:lady_skin/src/features/my_order/screens/order_detail_page.dart';
import 'package:lady_skin/src/features/my_order/screens/pay_order_page.dart';
import 'package:lady_skin/src/features/name/screens/change_name_page.dart';
import 'package:lady_skin/src/features/product/models/product.dart';
import 'package:lady_skin/src/features/product/screens/product_detail_page.dart';
import 'package:lady_skin/src/features/product/screens/product_list_by_category_page.dart';
import 'package:lady_skin/src/features/product/screens/product_list_by_promotion_page.dart';
import 'package:lady_skin/src/features/product/screens/product_subcategory_page.dart';
import 'package:lady_skin/src/features/review/screens/review_page.dart';
import 'package:lady_skin/src/features/setting/screens/setting_page.dart';
import 'package:lady_skin/src/features/shipping_address/screens/location_pickup_page.dart';
import 'package:lady_skin/src/features/shipping_address/screens/shipping_address_page.dart';

import 'package:lady_skin/src/shared/widgets/require_login.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case changePassword:
        return MaterialPageRoute(builder: (_) => ChangeChangePasswordPage());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingPage());
      case imageQuality:
        return MaterialPageRoute(builder: (_) => ImageQualityPage());
      case changeName:
        return MaterialPageRoute(builder: (_) => ChangeNamePage());
      case feedback:
        return MaterialPageRoute(builder: (_) => FeedbackPage());
      case checkout:
        return MaterialPageRoute(builder: (_) => CheckoutPage());
      case favourite:
        return MaterialPageRoute(builder: (_) => FavouritePage());

      case checkoutStatus:
        return MaterialPageRoute(builder: (_) => CheckoutStatusPage());
      case productPromotion:
        return MaterialPageRoute(builder: (_) => ProductListByPromotionPage());
      case review:
        if (args is Product) {
          return MaterialPageRoute(
              builder: (_) => ReviewPage(
                    product: args,
                  ));
        }
        return _errorRoute();
      case buyNow:
        if (args is BuyNowItem) {
          return MaterialPageRoute(
              builder: (_) => BuyNowPage(
                    buyNowItem: args,
                  ));
        }
        return _errorRoute();
      case cart:
        if (args is bool) {
          return MaterialPageRoute(
              builder: (_) => CartPageWrapper(
                    isNavigated: args,
                  ));
        }
        return _errorRoute();
      case myOrder:
        if (args is int) {
          return MaterialPageRoute(
              builder: (_) => MyOrderPage(
                    initIndex: args,
                  ));
        }
        return _errorRoute();
      case payOrder:
        if (args is MyOrder) {
          return MaterialPageRoute(
              builder: (_) => PayOrderPage(
                    myOrder: args,
                  ));
        }
        return _errorRoute();
      case locationPickup:
        return MaterialPageRoute(builder: (_) => LocationPickupPage());
      case requireLogin:
        if (args is Widget) {
          return MaterialPageRoute(
              builder: (_) => RequireLogin(
                    widget: args,
                  ));
        }
        return _errorRoute();
      case productDetail:
        if (args is Product) {
          return MaterialPageRoute(
              builder: (_) => ProductDetailPageWrapper(
                    productOrId: args,
                  ));
        }
        return _errorRoute();
      case productListByCategory:
        if (args is Category) {
          return MaterialPageRoute(
              builder: (_) => ProductListByCategoryPageWrapper(
                    categoryOrId: args,
                  ));
        }
        return _errorRoute();
      // case subCategoryProductWrapper:
      //   if (args is Category) {
      //     return MaterialPageRoute(
      //         builder: (_) => SubCategoryProductWrapperPage(
      //               category: args,
      //             ));
      //   }
      //   return _errorRoute();
      case productSubCategory:
        if (args is Map) {
          return MaterialPageRoute(
              builder: (_) => ProductSubCategoryPage(
                    initIndex: args["initIndex"],
                    categoryFeature: args["categoryFeature"],
                  ));
        }
        return _errorRoute();
      // case storeProfilePage:
      //   if (args is Store) {
      //     return MaterialPageRoute(
      //         builder: (_) => StoreProfilePage(
      //               store: args,
      //             ));
      //   }
      //   return _errorRoute();
      case loginRegister:
        if (args is bool) {
          return MaterialPageRoute(
              builder: (_) => LoginRegisterPage(
                    isLogin: args,
                  ));
        }
        return _errorRoute();
      case shippingAddress:
        if (args is bool) {
          return MaterialPageRoute(
              builder: (_) => ShippingAddressPage(
                    isView: args,
                  ));
        }
        return _errorRoute();

      case orderDetail:
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => OrderDetailPage(
                    orderId: args,
                  ));
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

// class MyAddressPageArgs {
//   String token;
//   PageOption pageOption;
//   MyAddressPageArgs({required this.token, required this.pageOption});
// }

// class OrderDetailPageArgs {
//   String orderId;
//   String token;
//   OrderDetailPageArgs({required this.orderId, required this.token});
// }

// class MyOrderPageArgs {
//   int initIndex;
//   MyOrderPageArgs({required this.initIndex});
// }
