import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  double get total => cartItems.fold(0, (sum, item) => sum + item.price);
  int get count => cartItems.length;

  void addProduct(Product product) {
    if (product.stock > 0) {
      cartItems.add(product);
      product.stock--; // Reactividad automática en HomeScreen
      
      Get.snackbar(
        "¡Añadido!", 
        "${product.name} se sumó al carrito ☕",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.brown.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(milliseconds: 800),
      );
    } else {
      Get.snackbar(
        "Sin Stock", 
        "Lo sentimos, no quedan más ${product.name}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // Si el usuario elimina un item del carrito antes de comprar, el stock regresa
  void removeProduct(int index) {
    cartItems[index].stock++; 
    cartItems.removeAt(index);
  }

  // elimina sólo una unidad del producto
  void removeSingle(Product product) {
    final index = cartItems.indexOf(product);
    if (index != -1) {
      cartItems[index].stock++;
      cartItems.removeAt(index);
    }
  }

  // Lista de productos agrupados con cantidad
  List<Map<String, dynamic>> get groupedItems {
    final Map<String, Map<String, dynamic>> temp = {};
    for (var p in cartItems) {
      if (temp.containsKey(p.id)) {
        temp[p.id]!['quantity']++;
      } else {
        temp[p.id] = {'product': p, 'quantity': 1};
      }
    }
    return temp.values
        .map((e) => {'product': e['product'], 'quantity': e['quantity']})
        .toList();
  }

  // Al confirmar, NO devolvemos el stock. El descuento es permanente.
  void confirmOrder() {
    if (cartItems.isNotEmpty) {
      cartItems.clear(); 
      Get.back(); // Regresa a la tienda
      Get.snackbar(
        '¡Pedido Exitoso!', 
        'Tu café se está preparando. El stock ha sido actualizado.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}