import 'product.dart';

class Order {
  final String id;
  final List<Product> items;
  final double total;
  String status; // 'Pendiente', 'Preparando', 'Listo'

  Order({
    required this.id,
    required this.items,
    required this.total,
    this.status = 'Pendiente',
  });
}