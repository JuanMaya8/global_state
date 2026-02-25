import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CartController cartController = Get.put(CartController());

  // Estos productos son los "objetos" reales. 
  // Al ser pasados por referencia, si el stock cambia aquí, cambia en toda la app.
  final List<Product> menu = [
    Product(id: '1', name: 'Espresso', price: 2.50, stock: 10),
    Product(id: '2', name: 'Cappuccino', price: 3.50, stock: 5),
    Product(id: '3', name: 'Muffin', price: 2.00, stock: 8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafetería Express ☕'),
        actions: [
          Obx(() => Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Get.toNamed('/cart'),
              ),
              if (cartController.count > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text('${cartController.count}', 
                      style: const TextStyle(fontSize: 10, color: Colors.white)),
                  ),
                )
            ],
          ))
        ],
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          final product = menu[index];
          return ListTile(
            title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            // El Obx escucha el product.stock que definimos como observable en el modelo
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.black54),
                ),
                Obx(() => Text(
                      'Disponibles: ${product.stock}',
                      style: TextStyle(
                        color: product.stock > 0 ? Colors.black54 : Colors.red,
                        fontWeight:
                            product.stock > 0 ? FontWeight.normal : FontWeight.bold,
                      ),
                    )),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.brown, size: 30),
              onPressed: () => cartController.addProduct(product),
            ),
          );
        },
      ),
    );
  }
}