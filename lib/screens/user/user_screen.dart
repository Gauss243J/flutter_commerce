import 'package:flutter/material.dart';
import 'package:flutter_commerce/widgets/widgets.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  static const String routeName='/user';

  static Route route(){
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context)=>const UserScreen(),
    );
  }


  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  static const String routeName='/user';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomAppBar(title: 'User'),
      bottomNavigationBar: const customNavBar(screen:routeName),
      body: Container(),

    );
  }
}
