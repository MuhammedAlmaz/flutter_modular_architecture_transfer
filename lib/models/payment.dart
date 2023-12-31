class PaymentBM {
  int price;
  String description;

  PaymentBM({required this.price, required this.description});

  factory PaymentBM.fromJson(Map<String, dynamic> json) {
    return PaymentBM(
      price: int.tryParse("${json['price']}") ?? 0,
      description: json['description'],
    );
  }
}
