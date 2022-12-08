import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:flutter_commerce/repositories/search/base_productsearch_repository.dart';

class ProductSearchRepository extends BaseProductSearchRepository{
  final FirebaseFirestore _firebaseFirestore;

  ProductSearchRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore=firebaseFirestore?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getProductsSearch(String search) {
    return _firebaseFirestore
        .collection('products')
        .where('name',isGreaterThanOrEqualTo:search.toLowerCase() )
        .where('name',isLessThanOrEqualTo: search.toLowerCase()+'\uf8ff')
        .snapshots()
        .map((snapshot){
      return snapshot
          .docs
          .map((doc) => Product
          .fromSnapshot(doc))
          .toList();
    });

  }
}
