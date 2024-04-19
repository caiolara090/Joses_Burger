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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            true, // Mostra automaticamente o botão de voltar
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top +
                  5.0), // Ajusta o padding superior
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Detalhes",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
  child: Padding(
    padding: EdgeInsets.all(16.0), // Adiciona espaço ao redor do conteúdo
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.produto != null)
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  widget.produto.foto,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.produto.nome ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ), 
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.produto?.descricao ?? '', // Verifica se a descrição é nula
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 18,
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
              'R\$ ${widget.produto?.preco.toStringAsFixed(2) ?? ''}',
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
              if (widget.produto != null) { // Verifica se o produto não é nulo
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
                    descricao: widget.produto.descricao ?? '',
                    valor: widget.produto.preco,
                    quantidade: 1,
                    imagem: widget.produto.foto,
                  ));
                }
                // Exibir um pop-up discreto dizendo "Nome do Produto adicionado ao carrinho"
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '${widget.produto.nome} adicionado ao carrinho',
        style: TextStyle(color: Colors.white), // Define a cor do texto
      ),
      duration: Duration(seconds: 1), // Define a duração do pop-up
      behavior: SnackBarBehavior.fixed, // Define a animação como flutuante
      backgroundColor: Colors.red, // Define a cor de fundo vermelho claro
    ),
  );
};
            },
            
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 244, 67, 54),
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
