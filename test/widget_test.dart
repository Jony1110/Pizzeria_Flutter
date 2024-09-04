import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart'; // Asegúrate de que esta línea apunte al archivo correcto

void main() {
  testWidgets('Test home page', (WidgetTester tester) async {
    // Construye el widget
    await tester.pumpWidget(const MyApp());

    // Verifica que el texto del AppBar esté presente
    expect(find.text('Bella Napoli'), findsOneWidget);
  });
}
