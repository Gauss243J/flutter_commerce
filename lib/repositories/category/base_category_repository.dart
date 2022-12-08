import 'package:flutter_commerce/models/models.dart';

abstract class BaseCategoryRepository{
  Stream<List<Category>>getAllCategories();
}
