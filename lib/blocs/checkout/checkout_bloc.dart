import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commerce/blocs/cart/cart_bloc.dart';
import 'package:flutter_commerce/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_commerce/repositories/checkout/checkout_repository.dart';
part 'checkout_state.dart';
part 'checkout_event.dart';

class CheckoutBloc extends Bloc<CheckoutEvent,CheckoutState>{
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    required CheckoutRepository checkoutRepository,
  }): _cartBloc=cartBloc,
        _checkoutRepository=checkoutRepository,
        super(cartBloc.state is CartLoaded
          ? CheckoutLoaded(
        products: (cartBloc.state as CartLoaded).cart.products,
        subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
        deliveryfee: (cartBloc.state as CartLoaded).cart.deliveryFeeString,
        total: (cartBloc.state as CartLoaded).cart.totalString,
          ):CheckoutLoading()){
    _cartSubscription= cartBloc.stream.listen((state) {
      if(state is CartLoaded){
        add(UpdatesCheckout(cart: state.cart));
      }
    });

  }

  @override
  Stream<CheckoutState>mapEventToState(
      CheckoutEvent event,
      ) async*{
    if(event is UpdatesCheckout){
      yield* _mapUpdateCheckoutToState(event,state);
    }else if(event is ConfirmCheckout){
      yield* _mapConfirmCheckoutToState(event,state);
    }
  }

  Stream<CheckoutState>_mapUpdateCheckoutToState(
      UpdatesCheckout event,
      CheckoutState state,
      ) async*{
    if(state is CheckoutLoaded){
      yield CheckoutLoaded(
        fullName:event.fullName??state.fullName,
        phoneNumber: event.phoneNumber ?? state.phoneNumber,
        products:event.cart?.products??state.products,
        deliveryfee:event.cart?.deliveryFeeString??state.deliveryfee,
        subtotal:event.cart?.subtotalString??state.subtotal,
        total:event.cart?.totalString??state.total,
        ville:event.ville??state.ville,
        quartier:event.quartier??state.quartier,
        avenue:event.avenue??state.avenue,
        repereAdress:event.repereAdress??state.repereAdress,
        modeLivraison:event.modeLivraison??state.modeLivraison,
        modePayement:event.modePayement??state.modePayement,
        delais:event.delais??state.delais,
      );
    }
  }

  Stream<CheckoutState>_mapConfirmCheckoutToState(
      ConfirmCheckout event,
      CheckoutState state,
      ) async*{
    _checkoutSubscription?.cancel();
    if(state is CheckoutLoaded){
      try{
        await _checkoutRepository.addCheckout(event.checkout);
        print('Done');
        yield CheckoutLoading();
      }catch(_){}

    }
  }


}

