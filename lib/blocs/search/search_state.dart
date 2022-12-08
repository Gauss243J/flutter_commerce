part of 'search_bloc.dart';

abstract class ProductSearchState extends Equatable{
  const ProductSearchState();
  @override
  List<Object> get props=>[];
}
class ProductSearchLoading extends ProductSearchState{
  @override
  List<Object> get props=>[];
}
class ProductSearchLoaded extends ProductSearchState{
  final List<Product> products;
  const ProductSearchLoaded({this.products= const <Product>[]});

  @override
  List<Object> get props=>[products];
}


class ProductSearchStateError extends ProductSearchState{
  @override
  List<Object> get props=>[];
}