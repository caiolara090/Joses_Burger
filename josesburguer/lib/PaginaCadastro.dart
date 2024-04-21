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

  bool _isAddressExpanded = false; // Track if the address section is expanded
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();
  final TextEditingController _referencePointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cadastro',
          style: TextStyle(fontSize: 28.0, color: Colors.white, fontWeight: FontWeight.bold,)
        ),
        backgroundColor: const Color.fromARGB(255, 244, 67, 54),
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
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255)
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextField(
                    controller: _nameController,
                    labelText: 'Nome do Usuário',
                    validator: (value) {
                      return value!.isEmpty || !RegExp(r'^[a-zA-ZÀ-ú]+$').hasMatch(value) ? 'Digite apenas letras' : null;
                    },
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                      controller: _emailController,
                      labelText: 'E-mail',
                      validator: (value) {
                        return value!.isEmpty || !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value) ? 'Digite um e-mail válido' : null;
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
                  ListTile(
                    title: const Text(
                      'Endereço',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: Icon(_isAddressExpanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () {
                        setState(() {
                          _isAddressExpanded = !_isAddressExpanded;
                        });
                      },
                    ),
                  ),
                  if (_isAddressExpanded) ...[
                    _buildTextField(
                      controller: _streetController,
                      labelText: 'Rua',
                      validator: (value) {
                        return value!.isEmpty ? 'Digite a rua' : null;
                      },
                      icon: Icons.home,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _neighborhoodController,
                      labelText: 'Bairro',
                      validator: (value) {
                        return value!.isEmpty ? 'Digite o bairro' : null;
                      },
                      icon: Icons.location_city,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _numberController,
                      labelText: 'Número',
                      validator: (value) {
                        return value!.isEmpty ? 'Digite o número' : null;
                      },
                      icon: Icons.confirmation_number,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _complementController,
                      labelText: 'Complemento',
                      validator: (value) {
                        return null;
                      },
                      icon: Icons.format_align_left,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _referencePointController,
                      labelText: 'Ponto de Referência',
                      validator: (value) {
                        return null;
                      },
                      icon: Icons.map,
                    ),
                    const SizedBox(height: 20),
                  ],
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 244, 67, 54),
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
    TextInputType? keyboardType,
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
      keyboardType: keyboardType,
    );
  }


  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String rua = _streetController.text.trim();
      final String bairro = _neighborhoodController.text.trim();
      final String numero = _numberController.text.trim();
      final String complemento = _complementController.text.trim();
      final String pontoref = _referencePointController.text.trim();

      final url = Uri.parse('http://10.0.2.2:3000/inserirUsuario');
      final response = await http.post(
        url,
        body: jsonEncode({
          'nome': name,
          'email': email,
          'senha': password,
          'rua': rua,
          'bairro': bairro,
          'numero': numero,
          'complemento': complemento,
          'ponto_ref': pontoref,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário $name cadastrado com sucesso!'),
          ),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro: Este e-mail já está cadastrado'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao cadastrar usuário'),
          ),
        );
      }
    }
  }
}