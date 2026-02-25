import 'package:get/get.dart';
import '../models/product.dart';

class ProductController extends GetxController {
  // Lista observable de productos
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Cargamos los productos al iniciar
  }

  void fetchProducts() {
    // Simulamos una carga de datos (podría ser de Firebase o una API)
    var productItems = [
      Product(id: '1', name: 'Espresso Intenso', price: 2.50, stock: 12),
      Product(id: '2', name: 'Caramel Macchiato', price: 4.50, stock: 5),
      Product(id: '3', name: 'Muffin de Arándanos', price: 3.00, stock: 8),
      Product(id: '4', name: 'Té Matcha Latte', price: 3.80, stock: 10),
    ];

    products.assignAll(productItems);
  }
}