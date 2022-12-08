import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/category/category_bloc.dart';
import 'package:flutter_commerce/blocs/product/product_bloc.dart';
import 'package:flutter_commerce/widgets/widgets.dart';

class HomeScreen  extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName='/';
  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_)=>const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar:  const CustomAppBar(title:'E-commerce'),
      bottomNavigationBar: const SizedBox(
        height: 40,
        child: customNavBar(screen:routeName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context,state) {
                if(state is CategoryLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if(state is CategoryLoaded){
                  return CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 1.5,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                    items: state.categories
                        .map((category) => HeroCarouselCard(category: category))//,product: Product.products[0]
                        .toList(),
                  );
                }
                else {
                  return const Text('Something went wrong');
                }
              }
            ),
            const SectionTitle(title: 'RECOMMENDED'),
            BlocBuilder<ProductBloc,ProductState>(
              builder: (context,state) {
                if(state is ProductLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
               if(state is ProductLoaded){
                  return
                    ProductCarousel(products:state.products
                      .where((product) => product.isRecommended)
                      .toList());
                }
                else {
                  return const Text('Something went wrong,');
                }
              }
            ),
            const SectionTitle(title: 'MOST POPULAR'),
            BlocBuilder<ProductBloc,ProductState>(
                builder: (context,state) {
                  if(state is ProductLoading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(state is ProductLoaded){
                    return ProductCarousel(products:state.products
                        .where((product) => product.isPopular)
                        .toList(),
                    );
                  }else {
                    return const Text('Something went wrong,');
                  }

                }
            ),
          ],
        ),
      ),
    );
  }
}



