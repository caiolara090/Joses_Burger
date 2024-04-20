import 'package:flutter/material.dart';
import 'package:josesburguer/Avaliacoes.dart';
import 'package:josesburguer/Pedidos.dart';
import 'package:josesburguer/Produtos.dart';
import 'package:josesburguer/DetalhesProduto.dart';
import 'package:josesburguer/MinhaConta.dart';
import 'Pedidos.dart';

class PaginaCardapio extends StatefulWidget {

  List<Pedido> pedidos; // Declaração do parâmetro pedidos
  String email_user;

  PaginaCardapio({required this.pedidos, required this.email_user}); // Construtor que aceita a lista de pedidos

  @override
  _PaginaCardapioState createState() => _PaginaCardapioState();
}

class _PaginaCardapioState extends State<PaginaCardapio> {
  int _currentIndex = 0;

  List<Produto> produtos = [
    Produto(
      nome: "Professor X",
      descricao:
        """Pão brioche, molho de tomate, hambúrguer de carne bovina 160g coberto com os queijos muçarela, provolone, catupiry e gorgonzola.
        
        Assim como o Professor X lidera os X-Men com sua mente poderosa, este hamburguer lidera o seu paladar em uma aventura épica. Prepare-se para uma explosão de sabores que transcende os limites da imaginação e experimente o hamburguer Professor X, um tributo delicioso a um dos maiores heróis dos quadrinhos.""",
      preco: 24.90,
      foto: "assets/H_X.png"
    ),
    Produto(
      nome: "Wolverine",
      descricao: 
        """Pão americano com gergelim, hambúrguer de carne bovina 160g, bacon, picles e molho barbecue da casa.

        Prepare-se para uma experiência gastronômica que vai despertar seus instintos mais selvagens e deixar um rastro de satisfação em seu paladar.""",
      preco: 21.90,
      foto: "assets/H_B_bacon.png"
    ),
    Produto(
      nome: "Tempestade",
      descricao:
          """Pão brioche com gergelim, 140g de costelinha de porco desfiada, muçarela ralada, cebola roxa e molho barbecue da casa.
          
          Venha experimentar essa explosão de sabores, capaz de alterar o clima, deixando tudo mais feliz.""",
      preco: 21.90,
      foto: "assets/H_pork.png"
    ),
    Produto(
      nome: "Ciclope",
      descricao:
          """Pão americano com gergelim, hambúrguer de carne bovina 120g, queijo cheddar, alface, tomate, ketchup e mostarda.

          Feche os olhos, dê uma mordida e deixe-se levar pela experiência única do hamburguer Ciclope.""",
      preco: 15.90,
      foto: "assets/H_normal.png"
    ),
    Produto(
      nome: "Spyke",
      descricao:
          """Pão americano com gergelim, hambúrguer de carne bovina 160g, bacon, picles, queijo cheddar, alface e ketchup.
          
          Assim como o Spyke usa seus espinhos para explorar novos caminhos, este hamburguer convida você a explorar novas combinações de sabores e descobrir uma nova dimensão de prazer gastronômico.""",
      preco: 19.90,
      foto: "assets/H_X_bacon.png"
    ),
    Produto(
      nome: "Fera",
      descricao:
          """Pão americano com gergelim, dois hambúrgueres de carne bovina 120g cada, queijo cheddar, alface, tomate e ketchup.
          
          Este hamburguer é para aqueles com uma fome voraz, uma verdadeira besta faminta prestes a atacar sua refeição como o Fera ataca seus desafios intelectuais""",
      preco: 19.90,
      foto: "assets/H_2_B.png"
    ),
    Produto(
      nome: "Vampira",
      descricao:
          """Pão americano com gergelim, 140g de peito de frango empanado, queijo cheddar, alface, tomate, cebola e ketchup.
          
          Este hamburguer vai sugar sua fome com a voracidade da Vampira, deixando você saciado e energizado para enfrentar qualquer desafio.""",
      preco: 15.90,
      foto: "assets/H_chicken.png"
    ),
    Produto(
      nome: "Lince Negra",
      descricao:
          """Pão americano com gergelim, 140g de filé de tilápia empanado, alface, cebola roxa e molho tártaro da casa.

          Experimente este hamburguer com a leveza e a suavidade da intangibilidade da Lince Negra, onde os sabores dançam em sua boca, como se fossem feitos de pura energia.""",
      preco: 15.90,
      foto: "assets/H_fish.png"
    ),
    Produto(
      nome: "Noturno",
      descricao: 
        """Pão vegano com gergelim, hambúrguer de soja 140g, tofu, alface, cebola roxa, pepino e ketchup.
      
        Com uma combinação única de ingredientes veganos, este prato celebra a versatilidade e a ousadia, assim como o próprio herói, proporcionando uma experiência culinária que vai teleportar seu paladar para novas dimensões de sabor e textura.""",
      preco: 15.90,
      foto: "assets/H_vegan.png"
    ),
    Produto(
      nome: "Batatas Jean Grey",
      descricao:
          """Batatas fritas em óleo vegetal
          
          Estas fritas parecem ter lido sua mente, assim como Jean Grey dos X-Men, entregando exatamente o que você deseja: uma combinação perfeita de crocância e sabor.""",
      preco: 6.50,
      foto: "assets/B_normal.png"
    ),
    Produto(
      nome: "Batatas Fenix Negra",
      descricao:
          """Batatas fritas, queijo cheddar e bacon.
          
          Estas batatas fritas com bacon e queijo capturam a intensidade cósmica da Fênix Negra, oferecendo uma explosão de sabores que vai incendiar seu paladar.""",
      preco: 10.50,
      foto: "assets/B_bacon.png"
    ),
    Produto(
      nome: "Salada Magneto",
      descricao:
          """Alface romana, queijo muçarela ralado, croutons, peito de frango fatiado e molho especial da casa.

          Trata-se de uma salada Caesar que cria uma experiência gastronômica que atrai e encanta os sentidos.""",
      preco: 19.90,
      foto: "assets/S_caesar.png"
    ),
    Produto(
      nome: "Salada Polaris",
      descricao:
          """Alface romana, tomate, cebola roxa e azeitona preta.
          
          É uma variedade de ingredientes vibrantes e frescos que se entrelaçam como os poderosos campos magnéticos que a Polaris controla.""",
      preco: 12.90,
      foto: "assets/S_normal.png"
    ),
    Produto(
      nome: "Coca-cola",
      descricao:
          "Lata de Coca-cola de 350mL.",
      preco: 6.50,
      foto: "assets/Coca.png"
    ),
    Produto(
      nome: "Pepsi 350mL",
      descricao:
          "Lata de Pepsi de 350mL.",
      preco: 6.50,
      foto: "assets/Pepsi.png"
    ),
    Produto(
      nome: "Guaraná Antártica 350mL",
      descricao:
          "Lata de Guaraná Antártica de 350mL.",
      preco: 6.50,
      foto: "assets/Guarana.png"
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
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 244, 67, 54),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20), // Adiciona espaço de 20 pixels acima da imagem
              Center(
                child: Image.asset(
                  'assets/JB_font.png', 
                  width: 350, 
                  height: 250, 
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
            colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)],
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
                        MaterialPageRoute(builder: (context) => AvaliacaoPage(email_user: widget.email_user,)), // Vai pra página de avaliações
                      );
                       //Navigator.pushNamed(context, '/avaliacao'); 
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
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
                                  produto: _filteredProdutos[index], pedidos: widget.pedidos,
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
                                  _filteredProdutos[index].descricao.length > 50
                                      ? _filteredProdutos[index].descricao.substring(0, 50) + '...'
                                      : _filteredProdutos[index].descricao,
                                  style: TextStyle(color: Colors.black),
                                ),
                                trailing: Text(
                                  'R\$${_filteredProdutos[index].preco.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                leading: Image.asset(
                                  _filteredProdutos[index].foto,
                                  height: 80,
                                  width: 70,
                                  fit: BoxFit.cover,
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
        backgroundColor: const Color.fromARGB(255, 244, 67, 54),
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
                        MaterialPageRoute(builder: (context) => CarrinhoPage(pedidos: widget.pedidos, email_user:widget.email_user)),
                      );
              break;
            case 2:
              //Navegue para alguma página
            Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaginaDados(pedidos: widget.pedidos, email_user:widget.email_user)),
                      );
              break;
          }
        },
      ),
    );
  }
}
