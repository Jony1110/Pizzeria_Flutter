class Pizza {
  final String nombre;
  final double precio;
  final bool esVegetariana;
  final List<String> ingredientes;
  final List<String> _ingredientesExtras;
  int cantidad;

  Pizza({
    required this.nombre,
    required this.precio,
    required this.esVegetariana,
    required this.ingredientes,
    List<String>? ingredientesExtras,
    this.cantidad = 1,
  }) : _ingredientesExtras = ingredientesExtras ?? [];

  List<String> get ingredientesExtras => _ingredientesExtras;

  void agregarIngredienteExtra(String ingrediente) {
    if (!_ingredientesExtras.contains(ingrediente)) {
      _ingredientesExtras.add(ingrediente);
    }
  }

  void eliminarIngredienteExtra(String ingrediente) {
    _ingredientesExtras.remove(ingrediente);
  }
}




