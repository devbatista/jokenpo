# Jokenpo API

API REST desenvolvida com Ruby on Rails para simular o jogo Pedra, Papel e Tesoura contra a máquina.

## Tecnologias Utilizadas

- Ruby on Rails
- PostgreSQL
- JSON API

## Como Rodar o Projeto Localmente

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/devbatista/jokenpo.git
   cd jokenpo
   ```

2. **Instale as dependências:**

   ```bash
   bundle install
   ```

3. **Configure o banco de dados:**

   Ajuste o arquivo `config/database.yml` conforme seu ambiente.

4. **Crie e migre o banco de dados:**

   ```bash
   rails db:create
   rails db:migrate
   ```

5. **Inicie o servidor:**

   ```bash
   rails server
   ```

   O servidor estará disponível em `http://localhost:3000`.

## Endpoints da API

### 1. Criar uma nova jogada

- **Endpoint:** `POST /api/plays`
- **Parâmetros (JSON):**

  ```json
  {
    "play": "pedra" | "papel" | "tesoura"
  }
  ```

- **Exemplo de requisição:**

  ```bash
  curl -X POST http://localhost:3000/api/plays \
  -H "Content-Type: application/json" \
  -d '{"play":"pedra"}'
  ```

- **Resposta (JSON):**

  ```json
  {
    "play": "pedra",
    "machine_play": "tesoura",
    "winner": "player" // ou "machine" ou "empate"
  }
  ```

### 2. Listar todas as jogadas

- **Endpoint:** `GET /api/plays`
- **Exemplo de requisição:**

  ```bash
  curl http://localhost:3000/api/plays
  ```

- **Resposta (JSON):**

  ```json
  [
    {
      "id": 1,
      "play": "pedra",
      "machine_play": "tesoura",
      "winner": "player",
      "created_at": "2025-05-16T12:00:00Z"
    },
    {
      "id": 2,
      "play": "papel",
      "machine_play": "papel",
      "winner": "empate",
      "created_at": "2025-05-16T12:05:00Z"
    }
  ]
  ```

### 3. Consultar uma jogada específica

- **Endpoint:** `GET /api/plays/:id`
- **Exemplo de requisição:**

  ```bash
  curl http://localhost:3000/api/plays/1
  ```

- **Resposta (JSON):**

  ```json
  {
    "id": 1,
    "play": "pedra",
    "machine_play": "tesoura",
    "winner": "player",
    "created_at": "2025-05-16T12:00:00Z"
  }
  ```

## Observações

- As jogadas válidas para o campo `play` são: `"pedra"`, `"papel"` e `"tesoura"`.
- O campo `winner` indica o vencedor da jogada: `"player"`, `"machine"` ou `"empate"`.
