import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';

class Avaliacao {
  final String nome;
  final int nota;
  final String comentario;
  final DateTime data;

  Avaliacao({
    required this.nome,
    required this.nota,
    required this.comentario,
    required this.data,
  });
}

class AvaliacaoPage extends StatefulWidget {
  String email_user;
  AvaliacaoPage({Key? key, required this.email_user}) : super(key: key);

  @override
  _AvaliacaoPageState createState() => _AvaliacaoPageState();
}

class _AvaliacaoPageState extends State<AvaliacaoPage> {
  List<bool> selectedStars = [true, false, false, false, false]; // Lista para controlar o estado das estrelas
  final TextEditingController _avaliacaoController = TextEditingController();
  List<Avaliacao> avaliacoes = [];
  late String nome="";
  double? notaMedia;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAvaliacoes();
    fetchNotaMedia();
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

  Future<void> fetchAvaliacoes() async {
    setState(() {
      isLoading = true;
    });

    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/buscarAvaliacoes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        avaliacoes = data
            .map((item) => Avaliacao(
                  nome: item['nome'],
                  nota: item['nota'],
                  comentario: item['texto_avaliacao'] ?? '',
                  data: DateTime.parse(item['data']),
                ))
            .toList();
        avaliacoes = avaliacoes.reversed.toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Falha ao carregar as avaliações');
    }
  }

  Future<void> fetchNotaMedia() async {
    setState(() {
      isLoading = true;
    });

    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/mediaAvaliacoes'));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      setState(() {
        notaMedia = data['media'].toDouble();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Falha ao carregar a nota média');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Avaliações',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  notaMedia != null ? 'Nota média: ${notaMedia!.toStringAsFixed(1)}' : 'Nota média: -',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child:
                        CircularProgressIndicator()) // Mostra o indicador de carregamento enquanto os dados são buscados
                : ListView.builder(
                    itemCount: avaliacoes.length,
                    itemBuilder: (context, index) {
                      final avaliacao = avaliacoes[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${avaliacao.nome} ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: List.generate(5, (index) {
                                if (index < avaliacao.nota) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.star_border,
                                    color: Colors.grey,
                                  );
                                }
                              }),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${avaliacao.comentario}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${avaliacao.data.day}/${avaliacao.data.month}/${avaliacao.data.year}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _avaliacaoController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Digite sua avaliação aqui',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text('Avaliar'),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(5, (index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        for (int i = 0; i <= index; i++) {
                                          selectedStars[i] = true; // Atualiza o estado das estrelas
                                        }
                                        for (int i = index + 1; i < 5; i++) {
                                          selectedStars[i] = false; // Reseta o estado das estrelas seguintes
                                        }
                                      });
                                    },
                                    child: Icon(
                                      selectedStars[index] ? Icons.star : Icons.star_border,
                                      color: selectedStars[index] ? Colors.yellow : null,
                                    ),
                                  );
                                }),
                              ),
                              actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () async {
                                      String avaliacaoTexto = _avaliacaoController.text;
                                      int notaAvaliacao = selectedStars.where((star) => star).length;
                                      // Enviar avaliação para o backend
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        final response = await http.post(
                                          Uri.parse(
                                              'http://10.0.2.2:3000/inserirAvaliacao'),
                                          headers: {
                                            'Content-Type': 'application/json'
                                          },
                                          body: json.encode({
                                            'nome': nome, // Nome do usuário
                                            'texto_avaliacao': avaliacaoTexto,
                                            'nota': notaAvaliacao,
                                          }),
                                        );

                                        setState(() {
                                          isLoading = false;
                                        });

                                        if (response.statusCode == 201) {

                                          _avaliacaoController.clear(); // Limpa o campo de texto

                                          // Ocultar o teclado
                                          FocusScope.of(context).unfocus();

                                          // Atualizar a lista de avaliações local com a nova avaliação
                                          setState(() {
                                            isLoading = true; // Mostrar indicador de carregamento
                                          });
                                          // Atualizar a lista de avaliações chamando fetchAvaliacoes()
                                          await fetchAvaliacoes();
                                          await fetchNotaMedia();

                                          setState(() {
                                            isLoading = false; // Esconder indicador de carregamento após a atualização
                                          });

                                          ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Avaliação inserida com sucesso!'),
                                            duration: Duration(seconds: 1), // Define a duração do SnackBar
                                            behavior: SnackBarBehavior.fixed, // Define a animação como flutuante
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                         Navigator.of(context).pop();
                                        } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Falha ao inserir a avaliação. Tente novamente mais tarde.'),
                                              duration: Duration(seconds: 1), // Define a duração do SnackBar
                                              behavior: SnackBarBehavior.fixed, // Define a animação como flutuante
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      } catch (error) {
                                        print(
                                            'Erro ao enviar avaliação: $error');
                                      }
                                      selectedStars = [true, false, false, false, false];
                                    },
                                    child: Text('Enviar'),
                                    style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Define a cor de fundo como vermelho
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    ),
                                  ),
                                ],
                              );
                          },
                        );
                      },
                    );
                  },
                  child: Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
