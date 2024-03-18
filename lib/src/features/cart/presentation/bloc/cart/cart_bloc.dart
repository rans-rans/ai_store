import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart.dart';
import '../../../domain/entities/firebase_cart.dart';
import '../../../domain/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  Stream<Cart> listenToCart({required String userId}) {
    return cartRepository.fetchUserCart(userId: userId)
      ..listen((event) {
        add(UpdateUserCart(cart: event));
      });
  }

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<UpdateUserCart>((event, emit) async {
      emit(CartFetchSuccess(cart: event.cart));
    });
    on<AddProductToCartEvent>((event, emit) async {
      await cartRepository
          .addProductToCart(
        cartItem: FirebaseCartItem(
          name: event.cartItem.name,
          productId: event.cartItem.productId,
          quantity: event.cartItem.quantity,
          price: event.cartItem.price,
          image: event.cartItem.image,
        ),
        userId: event.userId,
      )
          .then((value) {
        emit.isDone;
      });
    });

    on<RemoveProductFromCartEvent>((event, emit) async {
      await cartRepository.removeProductFromCart(
        productId: event.productId,
        userId: event.userId,
      );
    });

    on<IncrementItemQuantity>((event, emit) async {
      await cartRepository.incrementItemQuantity(
        productId: event.productId,
        userId: event.userId,
      );
    });

    on<DecrementItemQuantity>((event, emit) async {
      await cartRepository.decrementItemQuantity(
        productId: event.productId,
        userId: event.userId,
      );
    });
  }
}
