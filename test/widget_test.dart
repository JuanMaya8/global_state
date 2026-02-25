// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:global_state/main.dart';

void main() {
  testWidgets('añadir producto reduce stock en línea separada y persiste tras confirmar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Estar en pantalla principal con productos
    expect(find.text('Espresso'), findsOneWidget);

    // La línea de precio y la línea de stock deben existir por separado
    expect(find.text('\$2.50'), findsOneWidget);
    expect(find.text('Disponibles: 10'), findsOneWidget);

    // Añadir el primer producto (Espresso) usando el botón '+' original
    final addButton = find.byIcon(Icons.add_circle).first;
    await tester.tap(addButton);
    await tester.pump();

    // Stock debe haber disminuido
    expect(find.text('Disponibles: 9'), findsOneWidget);

    // El contador del carrito debe mostrar 1
    expect(find.text('1'), findsOneWidget);

    // Ir al carrito
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    // Ver el producto dentro del carrito
    expect(find.text('Espresso'), findsOneWidget);

    // Confirmar pedido
    await tester.tap(find.text('Confirmar Pedido'));
    await tester.pumpAndSettle();

    // Volver a la pantalla principal y stock debería seguir 9
    expect(find.text('Disponibles: 9'), findsOneWidget);
  });
}

