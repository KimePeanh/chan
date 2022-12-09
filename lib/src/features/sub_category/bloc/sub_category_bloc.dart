import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/sub_category/models/sub_category.dart';
import 'package:lady_skin/src/features/sub_category/repositories/sub_category_repository.dart';
import 'sub_category_event.dart';
import 'sub_category_state.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  List<SubCategory> subCategoryList = [];
  SubCategoryRepository _subCategoryRepository = SubCategoryRepository();
  @override
  SubCategoryBloc() : super(FetchingSubCategory());

  @override
  Stream<SubCategoryState> mapEventToState(SubCategoryEvent event) async* {
    if (event is FetchSubCategoryStarted) {
      yield FetchingSubCategory();
      try {
        await Future.delayed(Duration(milliseconds: 1000));
        List<SubCategory> temp = [];
        temp = await _subCategoryRepository.getSubCategory(
            categoryId: event.categoryId);
        subCategoryList.addAll(temp);
        yield FetchedSubCategory();
      } catch (e) {
        yield ErrorFetchingSubCategory(error: e.toString());
      }
    }
  }
}
