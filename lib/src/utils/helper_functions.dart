import 'dart:isolate';

import 'package:flutter/material.dart';

import '../features/cart/domain/entities/cart.dart';

double applyDiscount(double price, double discount) {
  if (discount <= 0 || discount >= 100) {
    return price;
  }
  double discountAsDecimal = discount / 100;
  double discountAmount = price * discountAsDecimal;
  return price - discountAmount;
}

void getCartTotalPriceFunction(List<CartItem> products, SendPort sendPort) {
  double total = 0.0;
  for (var item in products) {
    total += (applyDiscount(item.productPrice * item.quantity, item.discount));
  }
  sendPort.send(total);
}

class HelperFunctions {
  static String formatToCurrency(double amount) {
    return "GH₵ ${formatNumber(amount)}";
  }

  static String getDiscountAmount(double realPrice, double discount) {
    final finalAmount = realPrice - (discount / 100 * realPrice);
    return "GH₵ ${formatNumber(finalAmount)}";
  }

  static Future<double> getCartTotalPrice(List<CartItem> products) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      (sendPort) => getCartTotalPriceFunction(products, sendPort),
      receivePort.sendPort,
    );
    double response = await receivePort.first;
    return response;
  }

  static String formatNumber(double number) {
    if (number < 1000) {
      return number.toStringAsFixed(2);
    }
    if (number < 1000000) {
      double result = number / 1000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}k';
    }
    double result = number / 1000000.0;
    return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
  }

  static Future gotoPage({
    required BuildContext context,
    required Widget page,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  static snackShow(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
