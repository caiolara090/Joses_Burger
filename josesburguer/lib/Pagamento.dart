import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PagamentoPage extends StatelessWidget {
  final double total;

  PagamentoPage({required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento via PIX'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total do Pedido: R\$${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: QrImageView(
                data: 'https://random.cat/',
                version: QrVersions.auto,
                size: 200.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
