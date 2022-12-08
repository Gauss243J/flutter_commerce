part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable{
  const CheckoutEvent();
  @override
  List<Object?> get props=>[];
}

class UpdatesCheckout extends CheckoutEvent{
  final String? fullName;
  final String? phoneNumber;
  final int? modeLivraison;
  final int? modePayement;
  final String? ville;
  final String? quartier;
  final String? avenue;
  final String? repereAdress;
  final int? delais;
  final Cart? cart;

   const UpdatesCheckout({
     this.fullName,
     this.phoneNumber,
     this.modeLivraison,
     this.modePayement,
     this.ville,
     this.quartier,
     this.avenue,
     this.repereAdress,
     this.delais,
     this.cart,
});


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
    cart,
  ];

}

class ConfirmCheckout extends CheckoutEvent{
  final Checkout checkout;
  const ConfirmCheckout({required this.checkout});
  @override
  List<Object?> get props=>[checkout];
}
