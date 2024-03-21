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
  senha: String
});

// Definir o modelo do usuário
const User = mongoose.model('User', userSchema);

// Middleware para permitir o uso de JSON no corpo das requisições
app.use(express.json());

// Rota para inserir um novo usuário
app.post('/inserirUsuario', async (req, res) => {
  const { nome, email, idade, senha } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(senha, 10);
    const novoUsuario = new User({ nome, email, idade, senha: hashedPassword });
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

// Iniciar o servidor para inserir usuários
app.listen(3000, () => {
  console.log('Servidor para inserir usuários rodando na porta 3000/inserirUsuario');
  console.log('Servidor para inserir usuários rodando na porta 3000/verificarUsuario');
});
