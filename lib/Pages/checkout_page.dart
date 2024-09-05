import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/pizza.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(0, (sum, item) => sum + item['pizza'].precio * item['quantity']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Factura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de Pedido',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final pizza = cartItems[index]['pizza'] as Pizza;
                  final quantity = cartItems[index]['quantity'] as int;
                  return ListTile(
                    title: Text('${pizza.nombre} x$quantity'),
                    subtitle: Text('Ingredientes: ${pizza.ingredientes.join(', ')}\nIngredientes Extras: ${pizza.ingredientesExtras.join(', ')}'),
                    trailing: Text('\$${(pizza.precio * quantity).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Total'),
              trailing: Text('\$${total.toStringAsFixed(2)}'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                debugPrint('Botón de generar factura presionado');
                _printOrDownloadInvoice(cartItems, total);
              },
              child: const Text('Pedir'),
            ),
          ],
        ),
      ),
    );
  }

  void _printOrDownloadInvoice(List<Map<String, dynamic>> cartItems, double total) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Factura', style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              pw.Divider(),
              pw.Column(
                children: cartItems.map((item) {
                  final pizza = item['pizza'] as Pizza;
                  final quantity = item['quantity'] as int;
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('${pizza.nombre} x$quantity'),
                          pw.Text('\$${(pizza.precio * quantity).toStringAsFixed(2)}'),
                        ],
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text('Ingredientes: ${pizza.ingredientes.join(', ')}', style: const pw.TextStyle(fontSize: 12)),
                      pw.Text('Ingredientes Extras: ${pizza.ingredientesExtras.join(', ')}', style: const pw.TextStyle(fontSize: 12)),
                      pw.SizedBox(height: 16),
                      pw.Divider(),
                    ],
                  );
                }).toList(),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total', style: const pw.TextStyle(fontSize: 20)),
                  pw.Text('\$${total.toStringAsFixed(2)}'),
                ],
              ),
            ],
          );
        },
      ),
    );

    final pdfData = await pdf.save();

    if (kIsWeb) {

      // En la web, descarga el archivo PDF
       final blob = html.Blob([pdfData]);
       final url = html.Url.createObjectUrlFromBlob(blob);
       
       // ignore: unused_local_variable
       final anchor = html.AnchorElement(href: url)
         ..setAttribute('download', 'factura.pdf')
         ..click();
       html.Url.revokeObjectUrl(url);
    } else {
      
      // Impresion en celular.

      try {
        await Printing.layoutPdf(onLayout: (format) => pdfData);
        debugPrint('Factura generada exitosamente.');
      } catch (e) {
        debugPrint('Error al generar la factura: $e');
      }
    }
  }
}
