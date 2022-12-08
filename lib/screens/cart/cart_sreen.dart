import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/cart/cart_bloc.dart';
import 'package:flutter_commerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_commerce/widgets/widgets.dart';

class CartScreen  extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String routeName='/cart';

  static Route route(){
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_)=>const CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      bottomNavigationBar: BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            customNavBar(screen: '/cart'),
          ],
        ),
      ),
    ),

      body: SingleChildScrollView(
        child: BlocBuilder<CartBloc, CartState>(
            builder: (context,state) {
              if(state is WishlistLoading){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if(state is CartLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                state.cart.freeDeliveryString,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline5,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: const RoundedRectangleBorder(),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Add More Itm',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: state.cart
                                  .productQuantity(state.cart.products)
                                  .keys
                                  .length,
                              itemBuilder: (context, index) {
                                return CartProductCard(
                                  product:state.cart
                                        .productQuantity(state.cart.products)
                                        .keys
                                        .elementAt(index),
                                  quantity:state.cart
                                    .productQuantity(state.cart.products)
                                    .values
                                    .elementAt(index),);
                              },
                            ),
                          ),
                        ],
                      ),
                    const OrderSummary(),
                    ],
                  ),
                );
              }else{
                return const Text('Something went wrong');
              }
            }
            ),
      ),
    );
  }
}
