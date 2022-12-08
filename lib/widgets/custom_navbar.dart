import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/cart/cart_bloc.dart';
import 'package:flutter_commerce/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_commerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_commerce/models/models.dart';

class customNavBar extends StatelessWidget {
  final String screen;
  final Product? product;

  const customNavBar({
    Key? key,
    required this.screen,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _selectNavBar(context,screen)!,
        ),
      ),

    );
  }


List<Widget>? _selectNavBar(context,screen){
  switch(screen){
    case '/':
      return _buildNavBar(context);
    case '/catalog':
      return _buildNavBar(context);
    case '/wishlist':
      return _buildNavBar(context);
    case '/user':
      return _buildNavBar(context);
    case '/search':
      return _buildNavBar(context);
    case '/product':
      return _buildAddToCartNavBar(context,product);
    case '/cart':
      return _buildGoToCheckoutNavBar(context);
    case '/checkout':
      return _buildOrderNowNavBar(context);
  }
}


List<Widget>? _buildNavBar(context){
  return [
    IconButton(icon: const Icon(Icons.home, color: Colors.white,),onPressed: (){
      Navigator.pushNamed(context, '/');
    }, ),
    IconButton(icon: const Icon(Icons.shopping_cart,color: Colors.white,),onPressed: (){
      Navigator.pushNamed(context, '/cart');
    }, ),
    IconButton(icon: const Icon(Icons.search,color: Colors.white,),onPressed: (){
      Navigator.pushNamed(context, '/search');
    }, ),
    IconButton(icon: const Icon(Icons.person,color: Colors.white,),onPressed: (){
      Navigator.pushNamed(context, '/user');
    }, ),
  ];
}

List<Widget>_buildAddToCartNavBar(context,product){
  return[
    IconButton(
      icon: const Icon(Icons.share, color: Colors.white,),
      onPressed: (){},
    ),
    BlocBuilder<WishlistBloc,WishlistState>(
        builder: (context,state){
          if(state is WishlistLoading){
            return const CircularProgressIndicator();
          }
          if(state is WishlistLoaded){
            return IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white,),
              onPressed: (){
                const snackBar=
                SnackBar(content: Text('Added to your Wishlist !'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                context.read<WishlistBloc>().add(AddWishlistProduct(product));
              },
            );
          }
         return const Text('Something went wrong');
        },
    ),

    BlocBuilder<CartBloc,CartState>(
      builder: (context,state){
        if(state is CartLoading){
          return const CircularProgressIndicator();
        }
        if(state is CartLoaded){
          return ElevatedButton(
         onPressed: (){
           context.read<CartBloc>().add(CartProductAdded(product));
           Navigator.pushNamed(context, '/cart');
              },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: const RoundedRectangleBorder(),
            ),
            child: Text('ADD TO CART',
            style: Theme.of(context).textTheme.headline3,
            ),
          );
        }
        return const Text('Something went wrong');
      },
    ),
  ];
}

List<Widget> _buildGoToCheckoutNavBar(context){
  return [
  ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, '/checkout');
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      shape: const RoundedRectangleBorder(),
    ),
    child: Text(
      'GO TO CHECKOUT',
      style: Theme.of(context).textTheme.headline5,
    ),
  )
  ];
}

  List<Widget> _buildOrderNowNavBar(context){
    return [
      BlocBuilder<CheckoutBloc,CheckoutState>(
        builder: (context,state) {
          if(state is CheckoutLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is CheckoutLoaded){
            return ElevatedButton(
              onPressed: () {
                context
                .read<CheckoutBloc>()
                .add(ConfirmCheckout(
                    checkout: state.checkout));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: const RoundedRectangleBorder(),
              ),
              child: Text(
                'ORDER NOW',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }
          else {
            return
            const Text('Something went Wrong');
          }
        }
      )
    ];
  }

}
