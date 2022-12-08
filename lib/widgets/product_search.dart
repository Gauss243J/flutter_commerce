import 'package:flutter/material.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:flutter_commerce/widgets/widgets.dart';

class ProductSearch extends StatelessWidget {
  final List<Product> products;
  const ProductSearch({
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10.0),
              scrollDirection: Axis.vertical,
              itemCount: products.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: ProductCardSearch(product: products[index], widthFactor:1.1),
                );
              }
    );
  }
}
