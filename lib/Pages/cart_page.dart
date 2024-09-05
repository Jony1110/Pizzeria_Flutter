import 'package:flutter/material.dart';
import 'checkout_page.dart';
import '../models/pizza.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final pizza = cartItems[index]['pizza'] as Pizza;
                final quantity = cartItems[index]['quantity'] as int;
                return ListTile(
                  title: Text('${pizza.nombre} x$quantity'),
                  subtitle: Text('\$${(pizza.precio * quantity).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(cartItems: cartItems),
                  ),
                );
              },
              child: const Text('Comprar'),
            ),
          ),
        ],
      ),
    );
  }
}

