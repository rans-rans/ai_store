class HelperFunctions {
  static String formatToCurrency(double amount) {
    return "GH₵ ${amount.toStringAsFixed(2)}";
  }

  static String getDiscountAmount(double realPrice, double discount) {
    final finalAmount = realPrice - (discount / 100 * realPrice);
    return "GH₵ ${finalAmount.toStringAsFixed(2)}";
  }
}
