import 'package:flutter/material.dart';

class Pedido {
  final String nome;
  final String descricao;
  final double valor;
  int quantidade;
  final String imagem;

  Pedido({
    required this.nome,
    required this.valor,
    required this.descricao,
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