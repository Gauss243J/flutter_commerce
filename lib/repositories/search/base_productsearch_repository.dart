import 'package:flutter_commerce/models/models.dart';

abstract class BaseProductSearchRepository{
  Stream<List<Product>>getProductsSearch(String search);
}
