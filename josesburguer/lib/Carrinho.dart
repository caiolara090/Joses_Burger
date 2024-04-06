import 'package:flutter/material.dart';
import 'package:josesburguer/Cardapio.dart';
import 'package:josesburguer/MinhaConta.dart';

class CarrinhoPage extends StatefulWidget {
  CarrinhoPage({Key? key}) : super(key: key);

  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  int _currentIndex = 0;

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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Cardápio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Dados',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              // Navegue para alguma página
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaCardapio()),
              );
              break;
            case 1:
              // Já está na página de carrinho
              break;
            case 2:
              // Navegue para alguma página
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaDados()),
              );
              break;
          }
        },
      ),
    );
  }
}
