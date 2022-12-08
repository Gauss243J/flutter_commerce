import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_commerce/widgets/widgets.dart';

class WishListScreen  extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  static const String routeName='/wishlist';
  static Route route(){
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context)=> const WishListScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomAppBar(title: 'WishList'),
      bottomNavigationBar: const customNavBar(screen:routeName),
       body: BlocBuilder<WishlistBloc, WishlistState>(
           builder:(context,state) {
             if(state is WishlistLoading){
               return const Center(
                 child: CircularProgressIndicator(),
               );
             }
             if(state is WishlistLoaded){
               return GridView.builder(
                 padding: const EdgeInsets.symmetric(
                     horizontal: 8.0,
                     vertical: 16.0
                 ),
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 1, childAspectRatio: 1.95),
                 itemCount: state.wishlist.products.length,
                 itemBuilder: (BuildContext context, int index){
                   return Center(
                     child: ProductCard(
                       product: state.wishlist.products[index],
                       widthFactor: 1.1,
                       leftPosition: 100,
                       isWishList: true,
                     ),
                   );
                   },
               );
             }else{
               return const Text('Something went wrong');
           }
          },
      ),

    );
  }
}
