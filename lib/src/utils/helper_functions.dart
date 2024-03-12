import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;
import 'package:flutter/material.dart';

class HelperFunctions {
  static String formatToCurrency(double amount) {
    return "GH₵ ${formatNumber(amount)}";
  }

  static String getDiscountAmount(double realPrice, double discount) {
    final finalAmount = realPrice - (discount / 100 * realPrice);
    return "GH₵ ${formatNumber(finalAmount)}";
  }

  static String formatNumber(double number) {
    if (number < 1000) {
      return number.toStringAsFixed(2);
    } else if (number < 1000000) {
      double result = number / 1000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}k';
    } else {
      double result = number / 1000000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
    }
  }

  static List<Map<String, dynamic>> getDocumentList(
      QuerySnapshot<Map<String, dynamic>> response) {
    return response.docs.map((event) {
      return event.data();
    }).toList();
  }

  static gotoPage({
    required BuildContext context,
    required Widget page,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }
}
