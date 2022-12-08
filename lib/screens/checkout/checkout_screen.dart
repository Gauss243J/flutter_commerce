import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_commerce/widgets/custom_appbar.dart';
import 'package:flutter_commerce/widgets/custom_navbar.dart';
import 'package:flutter_commerce/widgets/order_summary.dart';


class CheckoutScreen extends StatefulWidget {
  static const String routeName='/checkout';

  const CheckoutScreen({Key? key}) : super(key: key);
  static Route route(){
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_)=> const CheckoutScreen(),
    );
  }

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  static const String routeName='/checkout';
  int val=1;
  int valpayement=1;
  int delai(products){
    if (products != null && products!.isNotEmpty) {
      int maxi = products!.first.delais;
      products!.forEach((e) {
        if (e.delais > maxi) maxi = e.delais;
      });
      return maxi;
    }
    else return 1;
  }



  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     appBar: const CustomAppBar(title: 'Checkout',),
     bottomNavigationBar: const customNavBar(screen:routeName),
     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.all(10.0),
         child: BlocBuilder<CheckoutBloc,CheckoutState>(
           builder: (context,state) {
             if(state is CheckoutLoading){
               return const Center(
                 child: CircularProgressIndicator(),
               );
             }
             if(state is CheckoutLoaded){
               context
                   .read<CheckoutBloc>()
                   .add(UpdatesCheckout(modeLivraison: val));

               context
                   .read<CheckoutBloc>()
                   .add(UpdatesCheckout(delais: delai(state.products)));

               context
                   .read<CheckoutBloc>()
                   .add(UpdatesCheckout(modePayement:  valpayement));


               return
                 Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment:CrossAxisAlignment.start,
                 children: [
                   Text(
                     'INFORMATION SUR LE CLIENT',
                     textAlign:  TextAlign.center,
                     style: Theme.of(context).textTheme.headline3,
                   ),

                   _builTextFormField((value){
                     context
                         .read<CheckoutBloc>()
                         .add(UpdatesCheckout(fullName: value));

                   }, context,'Nom Complet'),

                   _builTextFormField((value){
                     context
                         .read<CheckoutBloc>()
                         .add(UpdatesCheckout(phoneNumber: value));
                   }, context,'Numero phone'),

                   const SizedBox(height: 15,),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment:CrossAxisAlignment.start,
                     children: [
                       Text(
                         'INFORMATION LIVRAISON',
                         textAlign:  TextAlign.center,
                         style: Theme.of(context).textTheme.headline3,
                       ),
                       ListTile(
                         minVerticalPadding: 2,
                         title: Text("Livraison à domicile",style: Theme.of(context).textTheme.headline6,),
                         leading: Radio(
                           value: 1,
                           groupValue: val,
                           onChanged: (value) {
                             setState(() {
                               val = value as int;
                               context
                                   .read<CheckoutBloc>()
                                   .add(UpdatesCheckout(modeLivraison: val));
                             });
                           },
                           activeColor: Colors.black,
                         ),
                       ),
                       ListTile(
                         minVerticalPadding: 2,
                         title:  Text("Point de livraison",style: Theme.of(context).textTheme.headline6,),
                         leading: Radio(
                           value: 2,
                           groupValue: val,
                           onChanged: (value) {
                             setState(() {
                               val =value as int;
                               context
                                   .read<CheckoutBloc>()
                                   .add(UpdatesCheckout(modeLivraison: val));
                             });
                           },
                           activeColor: Colors.black,
                         ),
                       ),
                     ],
                   ),
                    val==1?
                    Column(
                     children: [
                   _builTextFormField((value){
                     context
                         .read<CheckoutBloc>()
                         .add(UpdatesCheckout(ville: value));
                   }, context,'Ville'),

                   _builTextFormField((value){
                     context
                         .read<CheckoutBloc>()
                         .add(UpdatesCheckout(quartier: value));
                   }, context,'Quartier'),

                       _builTextFormField((value){
                         context
                             .read<CheckoutBloc>()
                             .add(UpdatesCheckout(avenue: value));
                       }, context,'Avenue'),

                   _builTextFormField((value){
                     context
                         .read<CheckoutBloc>()
                         .add(UpdatesCheckout(repereAdress: value));
                   }, context,'Repères Adresses'),],  ): Container(
                      child:Text(
                        'Jusque là, on a pas de point de livraison, nous sommes entrain d\'y '
                            'travaillées,merci de choisir la livraison à domicile',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                   const SizedBox(height: 15,),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment:CrossAxisAlignment.start,
                     children: [
                       Text(
                         'MODE DE PAYEMENT',
                         textAlign:  TextAlign.center,
                         style: Theme.of(context).textTheme.headline3,
                       ),
                       ListTile(
                         minVerticalPadding: 2,
                         title: Text("Cash à la livraison",style: Theme.of(context).textTheme.headline6,),
                         leading: Radio(
                           value: 1,
                           groupValue: valpayement,
                           onChanged: (value) {
                             setState(() {
                               valpayement = value as int;
                               context
                                   .read<CheckoutBloc>()
                                   .add(UpdatesCheckout(modePayement:  valpayement));
                             });
                           },
                           activeColor: Colors.black,
                         ),
                       ),
                       ListTile(
                         minVerticalPadding: 2,
                         title:  Text("Mobile Money",style: Theme.of(context).textTheme.headline6,),
                         leading: Radio(
                           value: 2,
                           groupValue: valpayement,
                           onChanged: (value) {
                             setState(() {
                               valpayement =value as int;
                               context
                                   .read<CheckoutBloc>()
                                   .add(UpdatesCheckout(modePayement:  valpayement));
                             });
                           },
                           activeColor: Colors.black,
                         ),
                       ),
                     ],
                   ),
                   valpayement==1?Container():Container(
                     child:Text(
                       'Jusque là, on utilise un seul mode de payement, nous sommes entrain d\'y '
                           'travaillées,merci de choisir le payement par cash là livraison',
                       style: Theme.of(context).textTheme.headline6,
                     ),
                   ),

                   const SizedBox(height: 15,),
                   Text(
                     'ORDER SUMMARY',
                     textAlign:  TextAlign.center,
                     style: Theme.of(context).textTheme.headline3,
                   ),
                   const SizedBox(height: 4,),
                   Text(
                     'Les produits seront livrés dans ${delai(state.products)} jours ',
                     style: Theme.of(context).textTheme.headline5,
                   ),

                   const SizedBox(height: 6,),
                   const OrderSummary(),
                 ],
               );
             }
             else{
               return Text('Something went wrong');
             }
           }
         ),
       ),
     ),
    );
  }


  Padding _builTextFormField(
      Function(String)? onChanged,
      BuildContext context,
      String labelText,
      ){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child:
            Text(
              labelText,
              style: Theme.of(context).textTheme.bodyText1,),
          ),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(left: 4),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black
                  )
                )
              ),
            ),
          )
        ],
      ),
    );
  }



}
