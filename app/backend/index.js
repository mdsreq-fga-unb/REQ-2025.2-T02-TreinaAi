const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'meubanco',
  password: 'senha',
  port: 5432,
});

app.get("/", (req, res) => {
  res.send("Servidor local Node.js está rodando!");
});

app.get('/users', async (req, res) => {
  const result = await pool.query('SELECT * FROM users');
  res.json(result.rows);
});

app.listen(3000, () => console.log('Backend rodando em http://localhost:3000'));
