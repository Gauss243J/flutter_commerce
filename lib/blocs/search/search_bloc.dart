import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_commerce/repositories/search/productsearch_repository.dart';
part 'search_state.dart';
part 'search_event.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent,ProductSearchState>{
  final ProductSearchRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductSearchBloc({required ProductSearchRepository productSearchRepository})
      : _productRepository=productSearchRepository,
        super(ProductSearchLoading());

  @override
  Stream<ProductSearchState>mapEventToState(
      ProductSearchEvent event,
      ) async*{
    if(event is LoadProductsSearch){
      yield* _mapLoadProductsToState(event);
    }else if(event is UpdatesProductsSearch){
      yield* _mapUpdateProductsToState(event);
    }
  }

  Stream<ProductSearchState>_mapLoadProductsToState(LoadProductsSearch event
   ) async*{
    _productSubscription?.cancel();
    _productSubscription=_productRepository.getProductsSearch('').listen(
          (products)=> add(
        UpdatesProductsSearch(products),
      ),
    );
  }

  Stream<ProductSearchState>_mapUpdateProductsToState(
      UpdatesProductsSearch event) async*{
    yield ProductSearchLoaded(products: event.products);

  }
}
