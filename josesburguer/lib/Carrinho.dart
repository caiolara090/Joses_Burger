import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarrinhoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Lista de produtos comprados
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/hamburger.png'),
            ),
            title: const Text('Produto 1'),
            subtitle: const Text('Preço: R\$20'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                // Remover produto do carrinho
              },
            ),
          ),
          const Divider(), // Linha divisória entre os produtos

          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/hamburger.png'),
            ),
            title: const Text('Produto 2'),
            subtitle: const Text('Preço: R\$30'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                // Remover produto do carrinho
              },
            ),
          ),
          const Divider(), // Linha divisória entre os produtos

          // Outros produtos adicionais...

          // Botão comprar
          ElevatedButton(
            onPressed: () {
              // Ação ao pressionar o botão de comprar
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
            ),
            child: const Text(
              'Comprar',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CarrinhoPage(),
  ));
}
