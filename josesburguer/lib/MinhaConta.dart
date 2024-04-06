import 'package:flutter/material.dart';

class PaginaDados extends StatefulWidget {
  @override
  _PaginaDadosState createState() => _PaginaDadosState();
}

class _PaginaDadosState extends State<PaginaDados> {
  int _currentIndex = 2;
  late String nome;
  late String email;
  late int telefone;
  late String rua;
  late int numero;
  late String bairro;
  late String complemento;
  late String ponto_referencia;
  double saldo = 0.00;

  @override
  void initState() {
    super.initState();
    nome = 'Luiz Fernando Rocha';
    email = 'luiz.fernando50@gmail.com';
    telefone = 25;
    rua = "paranaiba";
    numero = 462;
    bairro = "Macaquinhos";
    complemento = "Perto do Posto Ipiranga";
    ponto_referencia = "Próximo ao Posto Ipiranga";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: Center(
          child: Text(
            'Informações da Conta',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 222, 222, 222)],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    SizedBox(height: 10),
                    _buildInfoTextField('Nome:', nome),
                    _buildInfoTextField('Email:', email),
                    _buildInfoTextField('Telefone:', telefone.toString()),
                    _buildInfoTextField('Rua:', rua),
                    _buildInfoTextField('Número:', numero.toString()),
                    _buildInfoTextField('Bairro:', bairro),
                    _buildInfoTextField('Complemento:', complemento),
                    _buildInfoTextField('Ponto de Referência:', ponto_referencia),
                    SizedBox(height: 20),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildInfoTextField(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: TextField(
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 25,
          color: const Color.fromARGB(255, 255, 0, 0),
        ),
        prefixText: ' ',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      style: TextStyle( 
        fontSize: 18,
        color: Colors.black,
      ),
      controller: TextEditingController(text: value),
    ),
  );
}

}