import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:josesburguer/Cardapio.dart';
import 'package:josesburguer/Produtos.dart';
import 'dart:convert';
import 'Pedidos.dart';

class PaginaDados extends StatefulWidget {
  final List<Pedido> pedidos;
  String email_user;

  PaginaDados({Key? key, required this.pedidos, required this.email_user}) : super(key: key);

  @override
  _PaginaDadosState createState() => _PaginaDadosState();
}

class _PaginaDadosState extends State<PaginaDados> {
  late String nome="";
  late String email="";
  late int telefone=0;
  late String rua="";
  late int numero=0;
  late String bairro="";
  late String complemento="";
  late String ponto_referencia="";
  bool isLoading = true; // Adiciona um estado para controlar se os dados estão sendo carregados ou não

  @override
  void initState() {
    super.initState();
    buscarDadosDaConta();
  }

  Future<void> buscarDadosDaConta() async {

    String email_usuario = widget.email_user;
    
    String url = "http://10.0.2.2:3000/buscarUsuario?email=$email_usuario";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          nome = data['nome'];
          email = data['email'];
          rua = data['rua'];
          numero = data['numero'];
          bairro = data['bairro'];
          complemento = data['complemento'];
          ponto_referencia = data['ponto_ref'];
          isLoading = false; // Define isLoading como false quando os dados são carregados com sucesso
        });
      } else {
        throw Exception('Falha ao carregar os dados do usuário');
      }
    } catch (error) {
      print('Erro ao carregar os dados do usuário: $error');
      setState(() {
        isLoading = false; // Define isLoading como false em caso de erro
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const Center(
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
      body: isLoading ? _buildLoadingIndicator() : _buildUserData(), // Exibe a animação de carregamento se isLoading for true, senão exibe os dados do usuário
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        currentIndex: 2,
        unselectedItemColor: Colors.white,
        items: const [
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
              // Navegue para a página do cardápio passando a lista de pedidos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaCardapio(pedidos: widget.pedidos, email_user: widget.email_user)),
              );
              break;
            case 1:
              // Navegue para a página do carrinho passando a lista de pedidos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarrinhoPage(pedidos: widget.pedidos, email_user: widget.email_user)),
              );
              break;
            case 2:
              // Navegue para a própria página (dados)
              break;
          }
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(), // Exibe a animação de carregamento
    );
  }

  Widget _buildUserData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
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
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  _buildInfoTextField('Nome:', nome),
                  _buildInfoTextField('Email:', email),
                  // _buildInfoTextField('Telefone:', telefone.toString()),
                  _buildInfoTextField('Rua:', rua),
                  _buildInfoTextField('Número:', numero.toString()),
                  _buildInfoTextField('Bairro:', bairro),
                  _buildInfoTextField('Complemento:', complemento),
                  _buildInfoTextField('Ponto de Referência:', ponto_referencia),
                  const SizedBox(height: 20),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 255, 0, 0),
          ),
          prefixText: ' ',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
        style: const TextStyle( 
          fontSize: 18,
          color: Colors.black,
        ),
        controller: TextEditingController(text: value),
      ),
    );
  }
}
