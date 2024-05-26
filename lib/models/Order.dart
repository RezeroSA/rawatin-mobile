class Order {
  final String? orderId;
  final String? layanan;
  final String? petugas;
  final String? total;

  Order({
    required this.orderId,
    required this.layanan,
    this.petugas,
    this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      layanan: json['name'],
      petugas: json['officer'] != null ? json['officer'] : null,
      total: json['total'],
    );
  }
}
