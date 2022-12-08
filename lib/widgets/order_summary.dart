import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/cart/cart_bloc.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
        builder: (context,state) {
          if(state is CartLoaded){
          return Column(
            children: [
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0,
                    vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Text(
                          'SUBTOTAL',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,
                        ),
                        Text(
                          '\$${state.cart.subtotalString}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Text(
                          'DELIVERY FREE',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,
                        ),
                        Text(
                          '\$${state.cart.deliveryFeeString}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.all(5.0),
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.black,),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white,),
                          ),
                          Text(
                            '\$${state.cart.totalString}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
    }else {return const Text('Something went wrong.');}
        }
      );
  }
}
