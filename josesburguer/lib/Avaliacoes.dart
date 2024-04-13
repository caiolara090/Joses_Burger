import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  AvaliacaoPage({Key? key}) : super(key: key);

  @override
  _AvaliacaoPageState createState() => _AvaliacaoPageState();
}

class _AvaliacaoPageState extends State<AvaliacaoPage> {
  final TextEditingController _avaliacaoController = TextEditingController();
  List<Avaliacao> avaliacoes = [];
  double? notaMedia;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAvaliacoes();
    fetchNotaMedia();
  }

  Future<void> fetchAvaliacoes() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('http://10.0.2.2:3000/buscarAvaliacoes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        avaliacoes = data.map((item) => Avaliacao(
          nome: item['nome'],
          nota: item['nota'],
          comentario: item['texto_avaliacao'] ?? '',
          data: DateTime.parse(item['data']),
        )).toList();
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

    final response = await http.get(Uri.parse('http://10.0.2.2:3000/mediaAvaliacoes'));

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
                ? Center(child: CircularProgressIndicator()) // Mostra o indicador de carregamento enquanto os dados são buscados
                : ListView.builder(
                    itemCount: avaliacoes.length,
                    itemBuilder: (context, index) {
                      final avaliacao = avaliacoes[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    // Aqui você pode enviar a avaliação para o backend
                    String avaliacaoTexto = _avaliacaoController.text;
                    // Faça algo com a avaliaçãoTexto, como enviar para o backend
                    // Lembre-se de limpar o texto da caixa de texto após enviar
                    _avaliacaoController.clear();
                  },
                  child: Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
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
