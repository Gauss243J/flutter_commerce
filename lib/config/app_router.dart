import 'package:flutter/material.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:flutter_commerce/screens/sreens.dart';


class AppRouter{
  static Route onGenerateRoute(RouteSettings settings){
   // print('this route :${settings.name}');

    switch(settings.name){
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case UserScreen.routeName:
        return UserScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case SearchScreen.routeName:
        return SearchScreen.route();
      case WishListScreen.routeName:
        return WishListScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute(){
    return MaterialPageRoute(
      settings: const RouteSettings(name:'/error'),
      builder: (_)=>Scaffold(
        appBar:
        AppBar( title: const Text('Error')
        ),
      ),
    );
  }
}