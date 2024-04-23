class Metadata {
  final String customerName;
  final String userId;
  final String phone;
  final List<Map<String, dynamic>> cartData;
  final String email;

  Metadata({
    required this.customerName,
    required this.userId,
    required this.phone,
    required this.cartData,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': customerName,
      'user_id': userId,
      'phone': phone,
      'cartData': cartData,
      'email': email,
    };
  }
}
