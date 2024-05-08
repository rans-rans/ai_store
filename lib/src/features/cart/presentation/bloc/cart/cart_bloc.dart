import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart.dart';
import '../../../domain/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  late Cart _cart;

  Future<Map<String, dynamic>> removeProductFromCart({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      final response = await cartRepository.removeProductFromCart(
        productId: productId,
        userId: userId,
        token: token,
      );

      add(GetUserCart(userId: userId, token: token));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<AddProductToCartEvent>((event, emit) async {
      try {
        final item = event.cartItem;
        final response = await cartRepository.addProductToCart(cartItem: {
          'product_id': item.productId,
          'id': item.userId,
          'quantity': 1,
          'variant': item.itemVariation,
        }, token: event.token);
        if (response['status'] == 'failed') {
          emit(CartFetchFailed(message: response['message']));
        }
        _cart.products.add(item);
        emit(CartFetchSuccess(cart: _cart));
      } catch (e) {
        rethrow;
      }
    });

    on<ChangeItemQuantityEvent>((event, emit) async {
      try {
        final productIndex = _cart.products
            .indexWhere((element) => element.productId == event.productId);
        await cartRepository.changeProductQuantity(
          productId: event.productId,
          userId: event.userId,
          quantity: event.quantity,
          token: event.token,
        );
        _cart.products[productIndex].quantity = event.quantity;

        emit(
          CartFetchSuccess(
            cart: _cart,
          ),
        );
      } catch (e) {
        emit(CartFetchFailed(message: e.toString()));
      }
    });

    on<ClearCart>((event, emit) {
      final cart = cartRepository.clearCart();
      emit(CartFetchSuccess(cart: cart));
    });

    on<GetUserCart>((event, emit) async {
      try {
        emit(CartFetchLoading());
        final response = await cartRepository.fetchUserCart(
          userId: event.userId,
          token: event.token,
        );
        _cart = response;
        emit(CartFetchSuccess(cart: response));
      } catch (e) {
        emit(CartFetchFailed(message: e.toString()));
      }
    });
  }
}
