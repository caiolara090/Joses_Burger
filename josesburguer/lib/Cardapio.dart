import 'package:flutter/material.dart';
import 'package:josesburguer/Avaliacoes.dart';
import 'package:josesburguer/Produtos.dart';
import 'package:josesburguer/DetalhesProduto.dart';
import 'package:josesburguer/MinhaConta.dart';

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 222, 222, 222)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(
                  right: 10), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), 
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _filteredProdutos = produtos
                                .where((produto) => produto.nome
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal:
                                  10), 
                          hintText: 'Pesquisar...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star,
                      color: Colors.yellow, 
                      size: 35, 
                    ),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AvaliacaoPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _filteredProdutos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesPagina(
                                  produto: _filteredProdutos[index],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  _filteredProdutos[index].nome,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  _filteredProdutos[index].descricao.length >
                                          50 
                                      ? _filteredProdutos[index]
                                              .descricao
                                              .substring(0, 50) +
                                          '...' 
                                      : _filteredProdutos[index]
                                          .descricao, 
                                  style: TextStyle(color: Colors.black),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/image_$index.png',
                                      height: 80,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'R\$${_filteredProdutos[index].preco.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
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
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CarrinhoPage()),
                      );
              break;
            case 2:
              //Navegue para alguma página
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
