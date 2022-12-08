import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/product/product_bloc.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:flutter_commerce/widgets/widgets.dart';

class CatalogScreen  extends StatelessWidget {

  static const String routeName='/catalog';
  static Route route({required Category category}){
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_)=> CatalogScreen(category: category),
    );
  }

  final Category category;
  const CatalogScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar:  CustomAppBar(title: category.name),
      bottomNavigationBar: const customNavBar(screen:routeName),
      body:BlocBuilder<ProductBloc,ProductState>(
          builder: (context,state) {
            if(state is ProductLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is ProductLoaded){
              final List<Product> categoryProducts= state
                  .products
                  .where((product) =>product.category==category.name).toList();
              return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10.0
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.0),
                  itemCount: categoryProducts.length,
                  itemBuilder: (BuildContext context, int index){
                    return Center(
                      child: ProductCard(
                        product: categoryProducts[index],
                        widthFactor: 2.2,
                      ),
                    );
                  }
              );
            }else {
              return const Text('Something went wrong,');
            }
          }
      ),
    );
  }
}
