import 'dart:convert';
import 'package:flutter/material.dart';

class Produto {
  String nome;
  String descricao;
  double preco;
  bool favorito;

  Produto({
    required this.nome,
    required this.descricao,
    required this.preco,
    this.favorito = false,
  });
}

class DetalhesPagina extends StatefulWidget {
  final Produto produto;

  DetalhesPagina({Key? key, required this.produto}) : super(key: key);

  @override
  _DetalhesPaginaState createState() => _DetalhesPaginaState();
}

class _DetalhesPaginaState extends State<DetalhesPagina> {
  bool _isFavorito = false;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.produto.nome,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(
                _isFavorito ? Icons.star : Icons.star_border,
                color: _isFavorito ? Colors.yellow : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isFavorito = !_isFavorito;
                });
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
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
          switch (index) {
            case 0:
              //Navegue para alguma página
              Navigator.pushReplacementNamed(context, '/cardapio');
              break;
            case 1:
              //Navegue para alguma página
              //Navigator.pushReplacementNamed(context, '/pagina2');
              break;
            case 2:
              //Navegue para alguma página
              Navigator.pushNamed(context, '/dados');
              break;
          }
        },
      ),
    );
  }
}
