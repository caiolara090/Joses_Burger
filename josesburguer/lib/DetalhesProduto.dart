import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:josesburguer/MinhaConta.dart';
import '/Cardapio.dart';
import '/Pedidos.dart';

class Produto {
  String nome;
  String descricao;
  double preco;
  bool favorito;
  String foto;

  Produto({
    required this.nome,
    required this.descricao,
    required this.preco,
    this.favorito = false,
    required this.foto,
  });
}

class DetalhesPagina extends StatefulWidget {
  final Produto produto;
  List<Pedido> pedidos; // Adicione a lista de pedidos como parâmetro

  DetalhesPagina({Key? key, required this.produto, required this.pedidos}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.produto != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/image_0.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.produto.descricao,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ), 
              ),
            ),
            SizedBox(height: 26),
            Padding(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: Center(
    child: Text(
      'R\$ ${widget.produto.preco.toStringAsFixed(2)}',
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ), 
    ),
  ),
),

            SizedBox(height: 16),
            Padding(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: ElevatedButton(
onPressed: () {
  bool pedidoExistente = false;

  for (var pedido in widget.pedidos) {
    if (pedido.nome == widget.produto.nome) {
      pedido.adicionarPedido();
      pedidoExistente = true;
      break;
    }
  }

  if (!pedidoExistente) {
    widget.pedidos.add(Pedido(
      nome: widget.produto.nome,
      descricao: widget.produto.descricao,
      valor: widget.produto.preco,
      quantidade: 1,
      imagem: widget.produto.foto,
    ));
  }
},

    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 50,
      ),
    ),
    child: const Text(
      'Adicionar',
      style: TextStyle(
        fontSize: 17.0,
        color: Colors.white, 
      ),
    ),
  ),
),


          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      //   selectedItemColor: Color.fromARGB(255, 0, 0, 0),
      //   currentIndex: _currentIndex,
      //   unselectedItemColor: Colors.white,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.fastfood),
      //       label: 'Cardápio',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'Carrinho',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Dados',
      //     ),
      //   ],
      //   onTap: (index) {
      //     switch (index) {
      //       case 0:
      //         //Navegue para alguma página
      //         Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => PaginaCardapio()),
      //                 );
      //         break;
      //       case 1:
      //         //Navegue para alguma página
      //         //Navigator.pushReplacementNamed(context, '/pagina2');
      //         break;
      //       case 2:
      //         //Navegue para alguma página
      //         Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => PaginaDados()),
      //                 );
      //         break;
      //     }
      //   },
      // ),
    );
  }
}
