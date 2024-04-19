const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

// Criar uma instância do Express
const app = express();

// Conectar ao banco de dados MongoDB
mongoose.connect('mongodb://localhost:27017/dados', { useNewUrlParser: true, useUnifiedTopology: true });

// Definir o schema do usuário
const userSchema = new mongoose.Schema({
  nome: String,
  email: String,
  idade: Number,
  senha: String,
  rua: String,
  bairro: String,
  numero: Number,
  complemento: String,
  ponto_ref: String,
});


// Definir o schema da avaliação
const avaliacaoSchema = new mongoose.Schema({
  nome: String,
  texto_avaliacao: String,
  nota: Number,
  data: { type: Date, default: Date.now } // Definir a data como a data atual por padrão
});

// Definir o modelo da avaliação
const Avaliacao = mongoose.model('Avaliacao', avaliacaoSchema);

// Obtendo o dia, mês e ano da data atual
// let dia = dataAtual.getDate();
// let mes = dataAtual.getMonth() + 1; // Lembrando que os meses são indexados de 0 a 11
// let ano = dataAtual.getFullYear();

// Definir o modelo do usuário
const User = mongoose.model('User', userSchema);

// Middleware para permitir o uso de JSON no corpo das requisições
app.use(express.json());

// Rota para inserir um novo usuário
app.post('/inserirUsuario', async (req, res) => {
  const { nome, email, idade, senha, rua, bairro, numero, complemento, ponto_ref } = req.body;
  try {
    // Verificar se o e-mail já está cadastrado
    const usuarioExistente = await User.findOne({ email });
    if (usuarioExistente) {
      return res.status(400).send('Este e-mail já está cadastrado');
    }

    // Se o e-mail não estiver cadastrado, continuar com a inserção do novo usuário
    const hashedPassword = await bcrypt.hash(senha, 10);
    const novoUsuario = new User({ nome, email, idade, senha: hashedPassword, rua, bairro, numero, complemento, ponto_ref });
    await novoUsuario.save();
    res.status(201).send('Usuário inserido com sucesso!');
  } catch (error) {
    console.error('Erro ao inserir usuário:', error);
    res.status(500).send('Erro ao inserir usuário');
  }
});

// Rota para verificar um usuário
app.post('/verificarUsuario', async (req, res) => {
  const { email, senha } = req.body;
  try {
    const usuario = await User.findOne({ email });
    if (!usuario) {
      res.status(404).send('Usuário não encontrado');
      return;
    }
    const senhaCorrespondente = await bcrypt.compare(senha, usuario.senha);
    if (senhaCorrespondente) {
      res.status(200).send('Login bem-sucedido!');
    } else {
      res.status(401).send('Senha incorreta');
    }
  } catch (error) {
    console.error('Erro ao verificar usuário:', error);
    res.status(500).send('Erro ao verificar usuário');
  }
});

// Rota para buscar os dados de um usuário pelo email
app.get('/buscarUsuario', async (req, res) => {
  const { email } = req.query;
  try {
    const usuario = await User.findOne({ email });
    if (!usuario) {
      res.status(404).send('Usuário não encontrado');
      return;
    }
    res.status(200).json({
      nome: usuario.nome,
      email: usuario.email,
      idade: usuario.idade,
      rua: usuario.rua,
      bairro: usuario.bairro,
      numero: usuario.numero,
      complemento: usuario.complemento,
      ponto_ref: usuario.ponto_ref
    });
  } catch (error) {
    console.error('Erro ao buscar usuário:', error);
    res.status(500).send('Erro ao buscar usuário');
  }
});

// Rota para buscar todas as avaliações
app.get('/buscarAvaliacoes', async (req, res) => {
  try {
    const avaliacoes = await Avaliacao.find();
    res.status(200).json(avaliacoes);
  } catch (error) {
    console.error('Erro ao buscar avaliações:', error);
    res.status(500).send('Erro ao buscar avaliações');
  }
});

// Rota para inserir uma nova avaliação
app.post('/inserirAvaliacao', async (req, res) => {
  const { nome, texto_avaliacao, nota } = req.body;

  // Verificar se todos os campos obrigatórios estão presentes e têm valores válidos
  if (!nome || !texto_avaliacao || !nota) {
    return res.status(400).send('Todos os campos (nome, comentario, nota) são obrigatórios');
  }

  // Verificar se a nota é um número inteiro entre 0 e 5
  if (!Number.isInteger(nota) || nota < 0 || nota > 5) {
    return res.status(400).send('A nota deve ser um número inteiro entre 0 e 5');
  }

  try {
    // Criar uma nova avaliação
    const novaAvaliacao = new Avaliacao({ nome, texto_avaliacao, nota });
    await novaAvaliacao.save();
    res.status(201).send('Avaliação inserida com sucesso!');
  } catch (error) {
    console.error('Erro ao inserir avaliação:', error);
    res.status(500).send('Erro ao inserir avaliação');
  }
});


// Rota para calcular e retornar a média de todas as avaliações
app.get('/mediaAvaliacoes', async (req, res) => {
  try {
    const avaliacoes = await Avaliacao.find();
    if (avaliacoes.length === 0) {
      const media = 0;
      return res.status(200).json({media});
    }
    
    // Calcular a média das notas das avaliações
    const totalNotas = avaliacoes.reduce((acc, curr) => acc + curr.nota, 0);
    const media = totalNotas / avaliacoes.length;

    res.status(200).json({ media });
  } catch (error) {
    console.error('Erro ao calcular a média de avaliações:', error);
    res.status(500).send('Erro ao calcular a média de avaliações');
  }
});


// Iniciar o servidor para inserir usuários
app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000!      ;)\n\n                                     :P');
});
