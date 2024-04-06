import 'package:flutter/material.dart';
import 'package:josesburguer/Cardapio.dart';
import 'package:josesburguer/MinhaConta.dart';
import '/Pagamento.dart';

class Pedido {
  final String nome;
  final double valor;
  int quantidade;
  final String imagem;

  Pedido({
    required this.nome,
    required this.valor,
    this.quantidade = 1,
    required this.imagem,
  });

  void adicionarPedido() {
    quantidade++;
  }

  void removerPedido() {
    if (quantidade > 1) {
      quantidade--;
    }
  }

  void excluirPedido() {
    quantidade = 0;
  }
}


class CarrinhoPage extends StatefulWidget {
  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {

  int _currentIndex = 0;

  List<Pedido> pedidos = [
    Pedido(
      nome: 'Sanduíche',
      valor: 15.99,
      quantidade: 3,
      imagem: "assets/hamburger.png",
    ),
    Pedido(
      nome: 'Batata Frita',
      valor: 5.99,
      imagem: "assets/fritas_1.png",
    ),
  ];

  double calcularTotal() {
    double total = 0;
    for (var pedido in pedidos) {
      total += pedido.valor * pedido.quantidade;
    }
    return total;
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text(
        'Carrinho',
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.red,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: ListView.builder(
  itemCount: pedidos.length,
  itemBuilder: (context, index) {
    final pedido = pedidos[index];
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(pedido.imagem),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${pedido.nome} (${pedido.quantidade}x)',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min, // Ajusta ao conteúdo
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        pedido.removerPedido();
                      });
                    },
                    splashRadius: 24, // Adicionando splash radius para o feedback visual
                    splashColor: Colors.grey.withOpacity(0.5), // Cor do splash
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        pedido.adicionarPedido();
                      });
                    },
                    splashRadius: 24, // Adicionando splash radius para o feedback visual
                    splashColor: Colors.grey.withOpacity(0.5), // Cor do splash
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        pedidos.removeAt(index);
                      });
                    },
                    splashRadius: 24, // Adicionando splash radius para o feedback visual
                    splashColor: Colors.grey.withOpacity(0.5), // Cor do splash
                  ),
                ],
              ),
            ],
          ),
          subtitle: Text(
            'Total: R\$${(pedido.valor * pedido.quantidade).toStringAsFixed(2)}',
          ),
        ),
        const Divider(), // Linha divisória entre os pedidos
      ],
    );
  },
),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Cardápio',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Dados',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              //Navegue para alguma página
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaginaCardapio()),
                      );
              break;
            case 1:
              //Navegue para alguma página
              //Navigator.pushReplacementNamed(context, '/pagina2');
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

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: CarrinhoPage(),
//   ));
// }
