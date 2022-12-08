part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable{
  const CategoryEvent();
  @override
  List<Object> get props=>[];
}

class LoadCategories extends CategoryEvent{}

// class CategoryProductAdded extends CategoryEvent{
//   final Product product;
//   const CategoryProductAdded(this.product);
//   @override
//   List<Object> get props=>[product];
// }

class UpdatesCategories extends CategoryEvent{
  final List<Category>categories;
  const UpdatesCategories(this.categories);
  @override
  List<Object> get props=>[categories];

}

// class CategoryProductRemoved extends CategoryEvent{
//   final Product product;
//   const CategoryProductRemoved(this.product);
//   @override
//   List<Object> get props=>[product];
//
// }