import 'package:get/get.dart';

class Product {
  final String id;
  final String name;
  final double price;
  // Definimos el stock como RxInt para que sea reactivo
  final RxInt _stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required int stock,
  }) : _stock = stock.obs;

  // Getter y setter para facilitar el uso en el código
  int get stock => _stock.value;
  set stock(int value) => _stock.value = value;
}