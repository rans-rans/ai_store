import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../orders/domain/entities/order.dart';
import '../../../domain/repositories/checkout_repository.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<bool> {
  final CheckoutRepository checkoutRepository;
  CheckoutCubit({required this.checkoutRepository}) : super(false);

  Future<Map<String, dynamic>> initializePayment({
    required Order cart,
    required String email,
  }) async {
    try {
      return await checkoutRepository.initializePayment(email: email, cart: cart);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyTransaction({
    required String key,
    required String ref,
  }) async {
    try {
      return await checkoutRepository.verifyTransaction(
        key: key,
        ref: ref,
      );
    } catch (e) {
      rethrow;
    }
  }
}
