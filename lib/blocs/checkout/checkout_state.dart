part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable{
  const CheckoutState();
  @override
  List<Object?> get props=>[];
}

class CheckoutLoading extends CheckoutState{}


class CheckoutLoaded extends CheckoutState{
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
  final Checkout checkout;

  CheckoutLoaded({
    this.fullName,
    this.phoneNumber,
    this.modeLivraison,
    this.modePayement,
    this.ville,
    this.quartier,
    this.avenue,
    this.repereAdress,
    this.delais,
    this.products,
    this.subtotal,
    this.deliveryfee,
    this.total,
  }): checkout= Checkout(
    fullName:fullName,
    phoneNumber: phoneNumber,
    modeLivraison:modeLivraison,
    modePayement:modePayement,
    ville:ville,
    quartier:quartier,
    avenue:avenue,
    repereAdress:repereAdress,
    delais:delais,
    products:products,
    subtotal:subtotal,
    deliveryfee:deliveryfee,
    total:total,
  );

  @override
  List<Object?> get props =>[
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
    total,
  ];
}

class CheckoutStateError extends CheckoutState{
}