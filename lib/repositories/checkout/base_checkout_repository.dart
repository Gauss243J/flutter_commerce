import 'package:flutter_commerce/models/models.dart';

abstract class BaseChechoutRepository{
  Future<void>addCheckout(Checkout checkout);
}