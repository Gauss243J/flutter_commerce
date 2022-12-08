part of 'search_bloc.dart';

abstract class ProductSearchEvent extends Equatable{
  const ProductSearchEvent();
  @override
  List<Object> get props=>[];
}

class LoadProductsSearch extends ProductSearchEvent{}

class UpdatesProductsSearch extends ProductSearchEvent{
  final List<Product>products;

  UpdatesProductsSearch(this.products);
  @override
  List<Object> get props=>[products];

}
