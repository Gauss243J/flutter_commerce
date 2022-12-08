import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_commerce/repositories/category/category_repository.dart';
part 'category_state.dart';
part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository=categoryRepository,
        super(CategoryLoading());

  @override
  Stream<CategoryState>mapEventToState(
      CategoryEvent event,
      ) async*{
    if(event is LoadCategories){
      yield* _mapLoadCategoriesToState();
    }else if(event is UpdatesCategories){
      yield* _mapUpdateCategoriesToState(event);
    }
  }

  Stream<CategoryState>_mapLoadCategoriesToState() async*{
    _categorySubscription?.cancel();
    _categorySubscription=_categoryRepository.getAllCategories().listen(
            (categories)=> add(
              UpdatesCategories(categories),
              ),
    );
  }

  Stream<CategoryState>_mapUpdateCategoriesToState(
      UpdatesCategories event) async*{
    yield CategoryLoaded(categories: event.categories);

  }

  // Stream<CategoryState>_mapCategoryProductAddedToState(
  //     CategoryProductAdded event,
  //     CategoryState state,
  //     ) async*{
  //
  //   if(state is CategoryLoaded) {
  //     try {
  //       yield CategoryLoaded(
  //           Category: Category(
  //               products:List.from(state.Category.products)
  //                 ..add(event.product)));
  //     } catch (_) {}
  //   }
  // }
  //
  //
  // Stream<CategoryState>_mapCategoryProductRemovedToState(
  //     CategoryProductRemoved event,
  //     CategoryState state,
  //     ) async*{
  //   if(state is CategoryLoaded) {
  //     try {
  //       yield CategoryLoaded(
  //           Category: Category(
  //               products:List.from(state.Category.products)
  //                 ..remove(event.product)));
  //     } catch (_) {}
  //   }
  // }
}

