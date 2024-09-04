import 'package:flutter/material.dart';
import 'menu_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizzeria Napoli'),
        backgroundColor: const Color.fromARGB(195, 206, 10, 10),
        elevation: 0, // Elimina la sombra de la AppBar
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [

          // Imagen de fondo desde una URL en línea

          Positioned.fill(
            child: SizedBox(
              width: 100,
              height: 100, 
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGPQWJ29KaO8LvldGERfRkrweOxR6B9j5WMg&s', // URL de la imagen
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Center(child: Text('Error al cargar la imagen', style: TextStyle(color: Colors.red)));
                },
              ),
            ),
          ),

          // Contenido de la página
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título
                Text(
                  '¡Bienvenido a Pizza Napoli!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.7),
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Botón para ver el menú
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 240, 76, 76), // Color de fondo del botón
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Borde redondeado
                    ),
                    elevation: 5, // Sombra del botón
                  ),
                  child: Text(
                    'Ver Menú',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
