import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/cart/cart_bloc.dart';
import 'package:flutter_commerce/blocs/category/category_bloc.dart';
import 'package:flutter_commerce/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_commerce/blocs/product/product_bloc.dart';
import 'package:flutter_commerce/blocs/search/search_bloc.dart';
import 'package:flutter_commerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_commerce/config/app_router.dart';
import 'package:flutter_commerce/config/theme.dart';
import 'package:flutter_commerce/repositories/category/category_repository.dart';
import 'package:flutter_commerce/repositories/checkout/checkout_repository.dart';
import 'package:flutter_commerce/repositories/product/product_repository.dart';
import 'package:flutter_commerce/repositories/search/productsearch_repository.dart';
import 'package:flutter_commerce/screens/sreens.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // Bloc.observer= SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>CartBloc()..add(CartStarted())),
        BlocProvider(
            create: (context)=>CheckoutBloc(
              cartBloc: context.read<CartBloc>(),
                checkoutRepository: CheckoutRepository(),
            ),
        ),
        BlocProvider(create: (_)=>WishlistBloc()..add(StartWishlist())),
        BlocProvider(
            create: (_)=>CategoryBloc(
            categoryRepository: CategoryRepository(),
        )..add(LoadCategories(),
        )),
        BlocProvider(
            create: (_)=>ProductBloc(
              productRepository: ProductRepository(),
        )..add(LoadProducts(),
        )),

        BlocProvider(
            create: (_)=>ProductSearchBloc(
              productSearchRepository: ProductSearchRepository(),
            )..add(LoadProductsSearch(),
            )),
      ],
      child: MaterialApp(
        title: 'E-Commerce',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}//stless


