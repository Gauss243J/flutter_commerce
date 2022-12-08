import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:flutter_commerce/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const String routeName='/search';
  static Route route(){
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context)=>SearchScreen(),
    );
  }

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String routeName='/search';
  final TextEditingController searchController= TextEditingController();
  String searchText=" ";

 String capitalize(String s)=> "${s[0].toUpperCase()}${s.substring(1)}";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.of(context).pop();
          },
    ),
          title: Card(
            child: TextField(
              style: const TextStyle(color: Colors.white) ,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search,color: Colors.white,),
                hintText: 'Search product.....',
                hintStyle:TextStyle(color: Colors.white) ,
              ),
              onChanged: (val){
                setState(() {
                  searchText=val;
                });
              },
            ),color: Colors.black,
          ),
          backgroundColor: Colors.black,
        ),
      bottomNavigationBar: const customNavBar(screen:routeName),

        body: StreamBuilder<QuerySnapshot>(
          stream:(searchText.isNotEmpty)
              ? FirebaseFirestore.instance
              .collection('products')
              .where('name',isNotEqualTo:searchText)
              .orderBy("name")
              .startAt([capitalize(searchText),])
              .endAt([capitalize(searchText)+'\uf8ff',])
              .snapshots()
          : FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context,snapshot){
            return (snapshot.connectionState==ConnectionState.waiting)
                ?const Center(child: CircularProgressIndicator(),)
                :ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10.0),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: ProductCardSearch(product: Product.fromSnapshot(snapshot.data!.docs[index]), widthFactor:1.1),
                  );
                }
            );

            }
          ),
    );
  }
}
