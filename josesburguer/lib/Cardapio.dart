import 'package:flutter/material.dart';
import 'package:josesburguer/DetalhesProduto.dart';

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
        preferredSize: Size.fromHeight(60), // Defina a altura do AppBar
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
                ), // Centraliza o texto à esquerda
              ),
              Image.asset(
                'assets/1.png', // Certifique-se de que o caminho da imagem está correto
                width: 70, // Defina a largura da imagem conforme necessário
                height: 75, // Defina a altura da imagem conforme necessário
              ),
              Text(
                'Burguer   ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ), // Centraliza o texto à direita
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
                  right: 10), // Adicione um espaçamento à direita
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), // Ajuste o padding horizontal
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
                                  10), // Ajuste o padding vertical e horizontal
                          hintText: 'Pesquisar...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.star,
                      color: Colors.yellow, // Define a cor amarela
                      size: 35, // Ajuste o tamanho do ícone
                    ),
                    onPressed: () {
                      // Implemente a ação do botão de estrela aqui
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
                                          50 // Verifica se a descrição é maior que 50 caracteres
                                      ? _filteredProdutos[index]
                                              .descricao
                                              .substring(0, 50) +
                                          '...' // Se sim, limita a 50 caracteres e adiciona reticências
                                      : _filteredProdutos[index]
                                          .descricao, // Se não, exibe a descrição completa
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
