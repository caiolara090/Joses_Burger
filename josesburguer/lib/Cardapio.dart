import 'package:flutter/material.dart';
import 'package:teste3/DetalhesProduto.dart';

class PaginaCardapio extends StatefulWidget {
  @override
  _PaginaCardapioState createState() => _PaginaCardapioState();
}

class _PaginaCardapioState extends State<PaginaCardapio> {
  int _currentIndex = 0;

  List<Produto> produtos = [
    Produto(
      nome: "Sanduíche de Frango Grelhado",
      descricao:
          "Frango grelhado com alface, tomate e maionese em um pão integral.",
      preco: 12.99,
    ),
    Produto(
      nome: "Sanduíche Vegetariano",
      descricao: "Pepino, cenoura, alface, tomate e queijo em um pão de grãos.",
      preco: 9.99,
    ),
    Produto(
      nome: "Hambúrguer Clássico",
      descricao:
          "Hambúrguer de carne, queijo, alface, tomate e molho especial em um pão de hambúrguer.",
      preco: 8.49,
    ),
    Produto(
      nome: "Wrap de Salada Caesar",
      descricao:
          "Frango grelhado, alface romana, queijo parmesão e molho Caesar em uma tortilha de trigo integral.",
      preco: 10.99,
    ),
    Produto(
      nome: "Sanduíche de Atum",
      descricao:
          "Atum, alface, cebola, picles e maionese em um pão de centeio.",
      preco: 11.49,
    ),
    Produto(
      nome: "Sanduíche de Frango Grelhado",
      descricao:
          "Frango grelhado com alface, tomate e maionese em um pão integral.",
      preco: 12.99,
    ),
    Produto(
      nome: "Sanduíche Vegetariano",
      descricao: "Pepino, cenoura, alface, tomate e queijo em um pão de grãos.",
      preco: 9.99,
    ),
    Produto(
      nome: "Hambúrguer Clássico",
      descricao:
          "Hambúrguer de carne, queijo, alface, tomate e molho especial em um pão de hambúrguer.",
      preco: 8.49,
    ),
    Produto(
      nome: "Wrap de Salada Caesar",
      descricao:
          "Frango grelhado, alface romana, queijo parmesão e molho Caesar em uma tortilha de trigo integral.",
      preco: 10.99,
    ),
    Produto(
      nome: "Sanduíche de Atum",
      descricao:
          "Atum, alface, cebola, picles e maionese em um pão de centeio.",
      preco: 11.49,
    ),
  ];

  TextEditingController _searchController = TextEditingController();
  List<Produto> _filteredProdutos = [];

  @override
  void initState() {
    super.initState();
    _filteredProdutos = List.from(produtos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "   Jose's",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ), 
              ),
              Image.asset(
                'assets/1.png', 
                width: 70, 
                height: 75, 
              ),
              Text(
                'Burguer   ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ), 
              ),
            ],
          ),
        ),
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
              //Navigator.pushReplacementNamed(context, '/pagina1');
              break;
            case 1:
              //Navegue para alguma página
              //Navigator.pushReplacementNamed(context, '/pagina2');
              break;
            case 2:
              //Navegue para alguma página
              Navigator.pushReplacementNamed(context, '/dados');
              break;
          }
        },
      ),
    );
  }
}
