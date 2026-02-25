import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Carrito 🛒')),
      body: Column(
        children: [
              Expanded(
            child: Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const Center(
                    child: Text('El carrito está vacío',
                        style: TextStyle(fontSize: 18)));
              }
              final grouped = cartController.groupedItems;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: grouped.length,
                itemBuilder: (context, index) {
                  final entry = grouped[index];
                  final product = entry['product'] as Product;
                  final qty = entry['quantity'] as int;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: const Icon(Icons.local_cafe, color: Colors.brown),
                      title: Text(product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$${product.price.toStringAsFixed(2)}'),
                          Text('Cantidad: $qty'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_forever,
                            color: Colors.redAccent),
                        onPressed: () => cartController.removeSingle(product),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.brown.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('\$${cartController.total.toStringAsFixed(2)}', 
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown)),
                  ],
                )),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  // Llamamos al nuevo método de confirmación
                  onPressed: () => cartController.confirmOrder(),
                  child: const Text('Confirmar Pedido', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}