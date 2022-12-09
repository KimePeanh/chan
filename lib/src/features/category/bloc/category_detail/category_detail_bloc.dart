import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/category/models/category.dart';
import 'package:lady_skin/src/features/category/repositories/category_detail_repository.dart';

import 'category_detail_event.dart';
import 'category_detail_state.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  CategoryDetailRepository _categoryDetailRepository =
      CategoryDetailRepository();
  @override
  CategoryDetailBloc() : super(FetchingCategoryDetail());

  @override
  Stream<CategoryDetailState> mapEventToState(
      CategoryDetailEvent event) async* {
    if (event is FetchCategoryDetail) {
      yield FetchingCategoryDetail();
      try {
        final Category category = await _categoryDetailRepository.getCategory(
            categoryId: event.categoryId);
        yield FetchedCategoryDetail(category: category);
      } catch (e) {
        yield ErrorFetchingCategoryDetail(error: e.toString());
      }
    }
  }
}
