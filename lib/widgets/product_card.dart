import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/cart/cart_bloc.dart';
import 'package:flutter_commerce/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishList;

  const ProductCard({
    Key? key,
    required this.product,
    this.widthFactor=2,
    this.leftPosition=5,
    this.isWishList=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue= MediaQuery.of(context).size.width/widthFactor;
    return InkWell(
      onTap: (){
         Navigator.pushNamed(
             context,
            '/product',
             arguments: product);
      },
      child: Stack(children: [
        SizedBox(
          width: widthValue,
          height: 150,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 80,
          left: leftPosition,
          child: Container(
            height: 60,
            width: widthValue-5-leftPosition,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(50),
            ),
          ),
        ),
        Positioned(
          top: 90,
          left:leftPosition+5,
          child: Container(
              height: 65,
              width:widthValue-15-leftPosition,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(90),
              ),

              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name,
                            style: Theme.of(context).textTheme.headline5!.copyWith(
                                color:Colors.white
                            ),
                          ),
                          Text('\$${product.price}',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                color:Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CartBloc,CartState>(
                      builder: (context,state) {
                        if(state is CartLoading){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if(state is CartLoaded){
                          return Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.white,),
                              onPressed: (){
                                context
                                    .read<CartBloc>()
                                    .add(CartProductAdded(product));
                              },
                            ),
                          );
                        }
                        else {return const Text('Something went wrong');}
                      }
                    ),
                    isWishList?
                    Expanded(
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,),
                        onPressed: (){},
                      ),
                    ): const SizedBox(),
                  ],
                ),
              )
          ),
        )
      ],
      ),
    );
  }
}
