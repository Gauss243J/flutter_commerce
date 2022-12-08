import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withAlpha(20),
      elevation:0,
      title: Align(
        alignment: Alignment.center,
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.white,
            )
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),

      leading: IconButton(
        onPressed:(){},
        icon: const Icon(
          Icons.add_shopping_cart_rounded,
          color: Colors.black,
        ),
      ),

      actions: [IconButton(icon: const Icon(Icons.favorite),onPressed: (){
        Navigator.pushNamed(context, '/wishlist');
      })],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}
