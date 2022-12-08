part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable{
  const ProductEvent();
  @override
  List<Object> get props=>[];
}

class LoadProducts extends ProductEvent{}

class UpdatesProducts extends ProductEvent{
  final List<Product>products;

  UpdatesProducts(this.products);
  @override
  List<Object> get props=>[products];

}
