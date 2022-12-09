// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:lady_skin/src/features/stores/models/store.dart';
// import 'package:lady_skin/src/utils/services/api_provider.dart';
// import 'package:lady_skin/src/utils/services/custom_exception.dart';

// enum StoresOption { ByDefault, ByCategory, BySubCategory, BySearch }

// class StoreRepository {
//   ApiProvider apiProvider = ApiProvider();
//   static const String baseUrl = "http://ecommerceapi.anakutapp.com/";
//   int rowPerPage = 10;

//   Future<List<Store>> getStores(
//       {required StoresOption storesOption,
//       required int page,
//       String categoryId,
//       String subCategoryId}) async {
//     final String url = baseUrl +
//         ((storesOption == StoresOption.ByDefault)
//             ? "/stores/"
//             : (storesOption == StoresOption.ByCategory)
//                 ? "stores/?row_per_page=$rowPerPage&page=$page&category_id=$categoryId"
//                 : "/stores/?row_per_page=$rowPerPage&page=$page&subid=$subCategoryId");

//     try {
//       Response response = await apiProvider.get(url, null, null);

//       if (response.statusCode == 200) {
//         List<Store> stores = List<Store>();
//         response.data["data"].forEach((val) {
//           stores.add(Store.fromJson(val));
//         });
//         return stores;
//       }
//       throw CustomException.generalException();
//     } catch (e) {
//       throw e;
//     }
//   }
// }
