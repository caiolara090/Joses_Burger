import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/PaginaCadastro.dart';
import '/Cardapio.dart';
import 'dart:convert';
import '/Pedidos.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  List<Pedido> pedidos = [];

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Jose\'s Burguer',
          style: TextStyle(fontSize: 28.0, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold,),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 67, 54),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)],
              ),
            ),
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextField(
                    controller: _emailController,
                    labelText: 'E-mail',
                    validator: (value) {
                      return value!.isEmpty || !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)
                          ? 'Digite um e-mail válido'
                          : null;
                    },
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _passwordController,
                    labelText: 'Senha',
                    isPassword: true,
                    validator: (value) {
                      return value!.isEmpty ? 'Digite a senha' : null;
                    },
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                      backgroundColor: const Color.fromARGB(255, 244, 67, 54), // Cor do botão
                      elevation: 5, // Elevação para criar um efeito de brilho
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10), // Espaçamento adicional
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                      );
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Text(
                      'Não tem uma conta? Registre-se',
                      style: TextStyle(color: Color.fromARGB(255, 2, 0, 125)),
                    ),
                  ),
                ],
              ),
            ),
          ),
         Positioned(
      bottom: 40.0, // Ajuste a posição vertical da imagem
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.4, // Ajuste a altura da imagem conforme necessário
          child: CircleAvatar(
            radius: 80, // Ajuste o tamanho da imagem
            child: Image.asset("assets/JBlogo.png", height: 200),
          ),
        ),
      ),
    ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool isPassword = false,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 120, 120).withOpacity(0.7), // Define a cor clara para o fundo
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color.fromARGB(255, 244, 67, 54), width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      obscureText: isPassword,
      validator: validator,
    );
  }

   Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      final url = Uri.parse('http://10.0.2.2:3000/verificarUsuario');
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'senha': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login bem-sucedido para $email!'),
          ),
        );
        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaginaCardapio(pedidos: pedidos, email_user:email)),
                      );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha incorreta!'),
          ),
        );
      }else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não identificado!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao fazer login!'),
          ),
        );
      }
    }
  }
}
