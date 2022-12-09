import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/category/models/category_content.dart';
import 'package:lady_skin/src/features/category/repositories/category_repository.dart';
import 'category_content_event.dart';
import 'category_content_state.dart';

class CategoryContentBloc
    extends Bloc<CategoryContentEvent, CategoryContentState> {
  CategoryRepository _categoryRepository = CategoryRepository();
  @override
  CategoryContentBloc() : super(FetchingCategoryContent());

  @override
  Stream<CategoryContentState> mapEventToState(
      CategoryContentEvent event) async* {
    if (event is FetchCategoryContent) {
      yield FetchingCategoryContent();
      try {
        CategoryContent _categoryContent = await _categoryRepository
            .getCategoryContent(categoryId: event.categoryId);

        yield FetchedCategoryContent(categoryContent: _categoryContent);
      } catch (e) {
        yield ErrorFetchingCategoryContent(error: e.toString());
      }
    }
  }
}
