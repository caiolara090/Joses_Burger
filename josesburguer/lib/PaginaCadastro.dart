import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cadastro',
          style: TextStyle(fontSize: 28.0, color: Colors.white)
        ),
        backgroundColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.8),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
                 Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 222, 222, 222)
                ],
          ),
        ),
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(
                controller: _nameController,
                labelText: 'Nome do Usuário',
                validator: (value) {
                  return value!.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)
                      ? 'Digite apenas letras'
                      : null;
                },
                icon: Icons.person,
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              _buildTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirmar Senha',
                isPassword: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirme sua senha';
                  }
                  if (value != _passwordController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                ),
                child: const Text(
                  'Registrar',
                  style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ],
          ),
        ),
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
        prefixIcon: icon != null ? Icon(icon, color: Color.fromARGB(255, 255, 255, 255)) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 120, 120).withOpacity(0.7),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
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

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      final url = Uri.parse('http://localhost:3000/inserirUsuario');
      final response = await http.post(
        url,
        body: jsonEncode({
          'nome': name,
          'email': email,
          'senha': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário $name cadastrado com sucesso!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar usuário'),
          ),
        );
      }
    }
  }
}
