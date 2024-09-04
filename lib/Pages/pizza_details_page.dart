import 'package:flutter/material.dart';
import '../models/pizza.dart';
import 'cart_page.dart'; // Asegúrate de importar la página de checkout


class PizzaDetailsPage extends StatefulWidget {
  final Pizza pizza;

  const PizzaDetailsPage({super.key, required this.pizza});

  @override
  PizzaDetailsPageState createState() => PizzaDetailsPageState();
}

class PizzaDetailsPageState extends State<PizzaDetailsPage> {
  late List<String> ingredients;
  double _quantity = 1;

  @override
  void initState() {
    super.initState();
    ingredients = widget.pizza.esVegetariana
        ? ['Pimiento', 'Tofu']
        : ['Pepperoni', 'Jamon', 'Salmon'];
    _quantity = widget.pizza.cantidad.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pizza.nombre),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Ingredientes Extras:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingrediente = ingredients[index];
                final isSelected = widget.pizza.ingredientesExtras.contains(ingrediente);

                return CheckboxListTile(
                  title: Text(ingrediente),
                  value: isSelected,
                  activeColor: Colors.blue, // El color azul se muestra cuando se selecciona el ingrediente
                  checkColor: Colors.white, // El color blanco cuando no se ha seleccionado
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        widget.pizza.agregarIngredienteExtra(ingrediente);
                      } else {
                        widget.pizza.eliminarIngredienteExtra(ingrediente);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cantidad:', style: TextStyle(fontSize: 16)),
                    Text(_quantity.toStringAsFixed(0), style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Slider(
                  value: _quantity,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _quantity.toStringAsFixed(0),
                  onChanged: (double value) {
                    setState(() {
                      _quantity = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    List<Map<String, dynamic>> cartItems = [];

                    cartItems.add({
                      'pizza': widget.pizza,
                      'quantity': _quantity.toInt(),
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(cartItems: cartItems), // Asegúrate de pasar el argumento requerido
                      ),
                    );
                  },
                  child: const Text('Añadir al carrito'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

