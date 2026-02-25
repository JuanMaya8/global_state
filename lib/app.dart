import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Coffee Shop GetX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.brown,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      // Definimos la pantalla inicial
      home: HomeScreen(),
      // Definimos las rutas de la app
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/cart', page: () => const CartScreen()),
      ],
    );
  }
}