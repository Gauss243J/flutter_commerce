import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:flutter_commerce/repositories/checkout/base_checkout_repository.dart';

class CheckoutRepository extends BaseChechoutRepository{
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore=firebaseFirestore?? FirebaseFirestore.instance;

  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore
        .collection('checkout')
        .add(checkout.toDocument());
  }

}

