// import 'package:bloc/bloc.dart';
// import 'package:lady_skin/src/features/stores/models/store.dart';
// import 'package:lady_skin/src/features/stores/repositories/store_repository.dart';

// import 'store_event.dart';
// import 'store_state.dart';

// class StoreBloc extends Bloc<StoreEvent, StoreState> {
//   StoreBloc() : super(Initializing());

//   final StoreRepository storeRepository = StoreRepository();
//   int storePage = 1;
//   List<Store> storeList = [];

//   @override
//   Stream<StoreState> mapEventToState(StoreEvent event) async* {
//     if (event is FetchStarted ||
//         event is FetchByCategoryStarted ||
//         event is FetchBySubCategoryStarted) {
//       yield (storePage == 1) ? Initializing() : FetchingStore();
//       if (event.isRefresh) {
//         storePage = 1;
//       }
//       try {
//         final List<Store> storelistTemp =
//             await ((event is FetchByCategoryStarted)
//                 ? storeRepository.getStores(
//                     storesOption: StoresOption.ByCategory,
//                     page: storePage,
//                     categoryId: event.categoryId)
//                 : (event is FetchBySubCategoryStarted)
//                     ? storeRepository.getStores(
//                         storesOption: StoresOption.BySubCategory,
//                         page: storePage,
//                         subCategoryId: event.subCategoryId)
//                     : storeRepository.getStores(
//                         page: storePage, storesOption: StoresOption.ByDefault));
//         if (event.isRefresh) {
//           storeList.clear();
//         }
//         storeList.addAll(storelistTemp);
//         storePage++;
//         yield FetchedStore();
//       } catch (_) {
//         yield ErrorFetchingStore(error: _);
//       }
//     }
//   }
// }
