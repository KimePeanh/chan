import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/category/models/category.dart';
import 'package:lady_skin/src/features/category/repositories/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  int currentIndex = 0;
  List<Category> category = [];
  CategoryRepository _categoryRepository = CategoryRepository();

  @override
  CategoryBloc() : super(FetchingCategory());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategory || event is FetchCategoryByStore) {
      yield FetchingCategory();
      try {
        await Future.delayed(Duration(milliseconds: 200));
        category = await ((event is FetchCategoryByStore)
            ? _categoryRepository.getCategoryByStore(storeId: event.storeId)
            : _categoryRepository.getCategory());

        yield FetchedCategory();
      } catch (e) {
        yield ErrorFetchingCategory(error: e.toString());
      }
    }
    if (event is ChangeIndex) {
      yield ChangingIndex();
      currentIndex = event.index;
      yield ChangedIndex();
    }
  }
}
