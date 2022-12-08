import 'package:equatable/equatable.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:intl/intl.dart';

class Checkout extends Equatable{
  final String? fullName;
  final String? phoneNumber;
  final int? modeLivraison;
  final int? modePayement;
  final String? ville;
  final String? quartier;
  final String? avenue;
  final String? repereAdress;
  final List<Product>? products;
  final int? delais;
  final String? subtotal;
  final String? deliveryfee;
  final String? total;


  const Checkout({
    required this.fullName,
    required this.phoneNumber,
    required this.modeLivraison,
    required this.modePayement,
    required this.ville,
    required this.quartier,
    required this.avenue,
    required this.repereAdress,
    required this.delais,
    required this.products,
    required this.subtotal,
    required this.deliveryfee,
    required this.total});

  @override
  List<Object?> get props=>[
    fullName,
    phoneNumber,
    modeLivraison,
    modePayement,
    ville,
    quartier,
    avenue,
    repereAdress,
    delais,
    products,
    subtotal,
    deliveryfee,
    total
  ];




  Map<String, Object>toDocument(){
    Map customerAdress = Map();
    customerAdress['ville']=ville;
    customerAdress['quartier']=quartier;
    customerAdress['avenue']=avenue;
    customerAdress['repereAdress']=repereAdress;

    return{
      'customerAdress':customerAdress,
      'customerName':fullName!,
      'customerNumber':phoneNumber!,
      'products':products!.map((product)=>product.id, ).toList(),
      'subtotal':subtotal!,
      'deliveryFee':deliveryfee!,
      'total':total!,
      'delais':delais!,
      'modeLivraison':modeLivraison!,
      'modePayement':modePayement!,
      'isAccepted':false,
      'isCancelled':false,
      'isDelivered':false,
      'customerId':0,
      'id':1,
      'createdAt':DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
    };
  }



}