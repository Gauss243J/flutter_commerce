import 'package:flutter_commerce/models/models.dart';

abstract class BaseProductRepository{
  Stream<List<Product>>getAllProducts();
}

