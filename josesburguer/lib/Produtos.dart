import 'package:flutter/material.dart';
import 'package:josesburguer/Cardapio.dart';
import 'package:josesburguer/MinhaConta.dart';
import '/Pagamento.dart';
import '/Pedidos.dart';

class CarrinhoPage extends StatefulWidget {

  List<Pedido> pedidos; // Adicione a lista de pedidos como parâmetro

  CarrinhoPage({Key? key, required this.pedidos}) : super(key: key);

  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {

  int _currentIndex = 1;

  // List<Pedido> pedidos = [
  //   Pedido(
  //     nome: 'Sanduíche',
  //     valor: 15.99,
  //     quantidade: 3,
  //     imagem: "assets/hamburger.png",
  //   ),
  //   Pedido(
  //     nome: 'Batata Frita',
  //     valor: 5.99,
  //     imagem: "assets/fritas_1.png",
  //   ),
  // ];

  double calcularTotal() {
    double total = 0;
    for (var pedido in widget.pedidos) {
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
    ),
    body: ListView.builder(
  itemCount: widget.pedidos.length,
  itemBuilder: (context, index) {
    final pedido = widget.pedidos[index];
    return Column(
      children: [
        ListTile(
  leading: CircleAvatar(
    backgroundImage: AssetImage(pedido.imagem),
  ),
  title: Text(
    '${pedido.nome} (${pedido.quantidade}x)',
    style: const TextStyle(
      fontSize: 18,
    ),
  ),
  subtitle: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Total: R\$${(pedido.valor * pedido.quantidade).toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                pedido.removerPedido();
              });
            },
            splashRadius: 24,
            splashColor: Colors.grey.withOpacity(0.5),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                pedido.adicionarPedido();
              });
            },
            splashRadius: 24,
            splashColor: Colors.grey.withOpacity(0.5),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                widget.pedidos.removeAt(index);
              });
            },
            splashRadius: 24,
            splashColor: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    ],
  ),
),

        const Divider(), // Linha divisória entre os pedidos
      ],
    );
  },
),
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
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaCardapio(pedidos: widget.pedidos)),
              );
              break;
            case 1:
              // Você já está na página do carrinho, não precisa fazer nada.
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaDados(pedidos: widget.pedidos)),
              );
              break;
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150, // Defina a largura desejada aqui
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PagamentoPage(total: calcularTotal())),
                              );
                            },
                            label: const Text(
                              'Pagar',
                              style: TextStyle(
                                fontSize: 20, // Defina o tamanho da fonte desejado aqui
                              ),
                            ),
                            icon: const Icon(Icons.payment),
                            backgroundColor: Colors.red,
                          ),
                        ),
                        Text(
                          'Total: R\$${calcularTotal().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
