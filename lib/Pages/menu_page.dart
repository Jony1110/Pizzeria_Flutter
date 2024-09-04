import 'package:flutter/material.dart';
import '../models/pizza.dart';
import 'pizza_details_page.dart';

class MenuPage extends StatelessWidget {
  final List<Pizza> pizzas = [
    Pizza(
      nombre: 'Vegetariana',
      precio: 599.99,
      esVegetariana: true,
      ingredientes: ['Tomate', 'Queso Mozzarella'], // Ingredientes por defecto
    ),
    Pizza(
      nombre: 'Pepperoni',
      precio: 470.25,
      esVegetariana: false,
      ingredientes: ['Pepperoni' , 'Tomate' , 'Queso Mozzarella'], // Ingredientes por defecto
    ),
  ];

  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      body: ListView.builder(
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          final pizza = pizzas[index];
          final ingredientes = pizza.ingredientes.join(', ');

          return ListTile(
            title: Text(pizza.nombre),
            subtitle: Text('$ingredientes\n\$${pizza.precio}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PizzaDetailsPage(pizza: pizza),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
