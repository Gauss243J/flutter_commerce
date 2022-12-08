import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/cart/cart_bloc.dart';
import 'package:flutter_commerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:flutter_commerce/widgets/widgets.dart';

class ProductScreen  extends StatelessWidget {
  static const String routeName='/product';

  static Route route({required Product product}){
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context)=>ProductScreen(product:product),
    );
  }

  final Product product;
   const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.share, color: Colors.white)),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder:(context,state) {
                return IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: (){
                      context
                          .read<WishlistBloc>()
                          .add(AddWishlistProduct(product));
                      const snackBar=
                      SnackBar(content: Text('Added to your WishList!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },);
                },
              ),
            BlocBuilder<CartBloc,CartState>(
              builder: (context,state) {
                return ElevatedButton(
                    onPressed: (){
                      context
                          .read<CartBloc>()
                          .add(CartProductAdded(product));
                      Navigator.pushNamed(context, '/cart');
                    },
                    child: Text(
                      'ADD CART',
                      style: Theme
                          .of(context)
                          .textTheme.headline3!
                    ),
                );
              }
            ),
            ],
          ),
        ),
      ),


      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.5,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: [HeroCarouselCard(product: product,),],
          ),

          Padding(
            padding:const  EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  color: Colors.black.withAlpha(50),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width-10,
                  height: 50,
                  color: Colors.black,
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                    child: Row(
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                        ),
                        Text(
                          '${product.price}',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ) ,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                    'Product Information',
                    style:Theme.of(context).textTheme.headline3,
                ),
              children: [
                ListTile(
                  title: Text('Lorem ipusm dolor sit amet, consector adipiscing',
                  style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              title: Text(
                'Delivery Information',
                style:Theme.of(context).textTheme.headline3,
              ),
              children: [
                ListTile(
                  title: Text('Lorem ipusm dolor sit amet, consector adipiscing',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}