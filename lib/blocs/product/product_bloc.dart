import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_commerce/repositories/product/product_repository.dart';
part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>{
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository=productRepository,
        super(ProductLoading());

  @override
  Stream<ProductState>mapEventToState(
      ProductEvent event,
      ) async*{
    if(event is LoadProducts){
      yield* _mapLoadProductsToState();
    }else if(event is UpdatesProducts){
      yield* _mapUpdateProductsToState(event);
    }
  }

  Stream<ProductState>_mapLoadProductsToState() async*{
    _productSubscription?.cancel();
    _productSubscription=_productRepository.getAllProducts().listen(
          (products)=> add(
        UpdatesProducts(products),
      ),
    );
  }

  Stream<ProductState>_mapUpdateProductsToState(
      UpdatesProducts event) async*{
    yield ProductLoaded(products: event.products);

  }
}

