import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:flutter_commerce/repositories/product/base_product_repository.dart';

class ProductRepository extends BaseProductRepository{
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore=firebaseFirestore?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection('products')
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