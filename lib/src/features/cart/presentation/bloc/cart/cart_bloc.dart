import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart.dart';
import '../../../domain/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  Future<void> addProductToCart({
    required CartItem cartItem,
    required String userId,
  }) async {
    try {
      return await cartRepository.addProductToCart(
        cartItem: cartItem,
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeProductFromCart({
    required String productId,
    required String userId,
  }) async {
    try {
      return await cartRepository.removeProductFromCart(
        productId: productId,
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeItemQuantity({
    required int quantity,
    required String productId,
    required String userId,
  }) async {
    try {
      return await cartRepository
          .changeProductQuantity(
        quantity: quantity,
        productId: productId,
        userId: userId,
      )
          .then((value) {
        add(
          ChangeItemQuantityEvent(
            userId: userId,
            quantity: quantity,
            productId: productId,
          ),
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<Cart> listenToCart({required String userId}) {
    return cartRepository.listenToCart(userId: userId)
      ..listen((event) {
        add(UpdateUserCartEvent(cart: event));
      });
  }

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<UpdateUserCartEvent>((event, emit) async {
      try {
        emit(CartFetchSuccess(cart: event.cart));
      } catch (e) {
        rethrow;
      }
    });
    on<ChangeItemQuantityEvent>((event, emit) {
      //do nothing
    });
  }
}
