import 'package:flutter/material.dart';

class Avaliacao {
  final String nome;
  final String usuario;
  final int nota;
  final String comentario;
  final DateTime data;

  Avaliacao({
    required this.nome,
    required this.usuario,
    required this.nota,
    required this.comentario,
    required this.data,
  });
}

class AvaliacaoPage extends StatelessWidget {
  AvaliacaoPage({Key? key}) : super(key: key);

  final List<Avaliacao> avaliacoes = [
    Avaliacao(
      nome: 'João',
      usuario: '@joao123',
      nota: 5,
      comentario: 'Excelente produto!',
      data: DateTime.now(),
    ),
    Avaliacao(
      nome: 'João',
      usuario: '@joao123',
      nota: 5,
      comentario: 'Excelente produto!',
      data: DateTime.now(),
    ),
    Avaliacao(
      nome: 'João',
      usuario: '@joao123',
      nota: 5,
      comentario: 'Excelente produto!',
      data: DateTime.now(),
    ),
    Avaliacao(
      nome: 'Rosalía',
      usuario: '@yosoymuymia',
      nota: 5,
      comentario: 'Adorei o Hamburguer Saul Goodman acompanhado da limonada Jesse Pinkman com batatas Indiana Jones! Obrigada pelo carinho',
      data: DateTime.now(),
    ),
    Avaliacao(
      nome: 'Pessoa Chata',
      usuario: '@amargurado',
      nota: 3,
      comentario: 'Pedi o hamburguer e o entregador não me deu boa noite quando chegou, aff!!',
      data: DateTime.now(),
    ),
    // Adicione mais avaliações aqui conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nota média: 5.0 ', // Aqui será dinâmico, apenas um exemplo
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
              child: ListView.builder(
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
                                  color: Colors.red, // Define a cor de fundo como vermelho
                                  borderRadius: BorderRadius.circular(8.0), // Define bordas arredondadas
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
                                    Text(
                                      '${avaliacao.usuario}',
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                      ),
                                    ),
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
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(AvaliacaoPage(
//   ));
// }
