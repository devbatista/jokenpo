
# Jokenpo API

Projeto simples de API REST para simular o jogo **Jokenpo** (Pedra, Papel e Tesoura).

## Tecnologias

- Ruby on Rails  
- PostgreSQL (ou outro banco configurado)  
- JSON API  

## Como rodar

1. Clone o repositório:  
   ```bash
   git clone https://github.com/devbatista/jokenpo.git
   cd jokenpo
   ```

2. Instale as dependências:  
   ```bash
   bundle install
   ```

3. Configure o banco de dados no arquivo `.env` ou `config/database.yml` conforme seu ambiente.

4. Rode as migrações:  
   ```bash
   rails db:migrate
   ```

5. Inicie o servidor:  
   ```bash
   rails server
   ```

## Endpoints da API

### 1. Criar uma nova partida

- **POST** `/matches`

- **Parâmetros:**  
  ```json
  {
    "player1_move": "pedra" | "papel" | "tesoura",
    "player2_move": "pedra" | "papel" | "tesoura"
  }
  ```

- **Exemplo de request:**  
  ```bash
  curl -X POST http://localhost:3000/matches \
  -H "Content-Type: application/json" \
  -d '{"player1_move":"pedra","player2_move":"tesoura"}'
  ```

- **Resposta:**  
  ```json
  {
    "id": 1,
    "player1_move": "pedra",
    "player2_move": "tesoura",
    "winner": "player1",
    "created_at": "2025-05-16T12:00:00Z"
  }
  ```

### 2. Listar todas as partidas

- **GET** `/matches`

- **Exemplo de request:**  
  ```bash
  curl http://localhost:3000/matches
  ```

- **Resposta:**  
  ```json
  [
    {
      "id": 1,
      "player1_move": "pedra",
      "player2_move": "tesoura",
      "winner": "player1",
      "created_at": "2025-05-16T12:00:00Z"
    },
    {
      "id": 2,
      "player1_move": "papel",
      "player2_move": "papel",
      "winner": "empate",
      "created_at": "2025-05-16T12:05:00Z"
    }
  ]
  ```

### 3. Consultar uma partida específica

- **GET** `/matches/:id`

- **Exemplo de request:**  
  ```bash
  curl http://localhost:3000/matches/1
  ```

- **Resposta:**  
  ```json
  {
    "id": 1,
    "player1_move": "pedra",
    "player2_move": "tesoura",
    "winner": "player1",
    "created_at": "2025-05-16T12:00:00Z"
  }
  ```

## Observações

- Os valores válidos para as jogadas são `"pedra"`, `"papel"` e `"tesoura"` (sempre em letras minúsculas).  
- O campo `winner` pode conter `"player1"`, `"player2"` ou `"empate"`.

---
