import 'package:flutter/material.dart';
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
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min, // Ajusta ao conteúdo
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        pedido.removerPedido();
                      });
                    },
                    splashRadius: 24, // Adicionando splash radius para o feedback visual
                    splashColor: Colors.grey.withOpacity(0.5), // Cor do splash
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        pedido.adicionarPedido();
                      });
                    },
                    splashRadius: 24, // Adicionando splash radius para o feedback visual
                    splashColor: Colors.grey.withOpacity(0.5), // Cor do splash
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
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

    bottomNavigationBar: Container(
      width: double.infinity,
      height: 50,
      color: Colors.red,
      child: Center(
        child: Text(
          'Total: R\$${calcularTotal().toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PagamentoPage(total: calcularTotal())),
    );
  },
  label: const Text(
    'Pagar',
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  backgroundColor: Colors.red,
  icon: const Icon(Icons.payment),
  splashColor: Colors.red.withOpacity(0.5), // Cor do splash
),

    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );
}
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CarrinhoPage(),
  ));
}
