Number Guessing Game
Este é um projeto de jogo de adivinhação de números em Bash, desenvolvido como parte do curso no FreeCodeCamp. O jogo utiliza PostgreSQL para armazenar informações sobre os usuários e suas estatísticas de jogo, como o número de tentativas em que acertaram o número e a melhor pontuação de cada usuário.

Funcionalidades
Geração de um número secreto aleatório entre 1 e 1000.
Criação e gestão de uma base de dados PostgreSQL para armazenar informações dos usuários e jogos.
Permite que o usuário jogue múltiplas partidas e armazena o menor número de tentativas necessárias para acertar o número secreto.
Exibe mensagens diferentes para novos usuários e usuários recorrentes, com estatísticas personalizadas.
Requisitos
PostgreSQL: Para armazenar as informações dos usuários e estatísticas do jogo.
Bash: Para executar o script do jogo (number_guess.sh).
Configuração do Projeto
Clone o repositório:

bash
Copiar código
git clone <URL-do-repositório>
cd number_guessing_game
Crie a base de dados number_guess e a tabela users:

sql
Copiar código
CREATE DATABASE number_guess;
\c number_guess
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(22) UNIQUE NOT NULL,
  games_played INT DEFAULT 0,
  best_game INT
);
Verifique se o script number_guess.sh tem permissões de execução:

bash
Copiar código
chmod +x number_guess.sh
Como Jogar
Execute o script:

bash
Copiar código
./number_guess.sh
Digite o seu nome de usuário. Se for a primeira vez que joga, você verá uma mensagem de boas-vindas. Caso contrário, verá o número de jogos anteriores e a melhor pontuação.

O jogo irá pedir para você adivinhar o número secreto entre 1 e 1000:

Se o palpite for muito alto, o jogo responderá "É mais baixo que isso, adivinhe novamente".
Se o palpite for muito baixo, o jogo responderá "É mais alto que isso, adivinhe novamente".
Se você inserir algo que não seja um número, o jogo responderá "Isso não é um número inteiro, tente novamente".
O jogo termina quando o número secreto é adivinhado, e a quantidade de tentativas é armazenada na base de dados.

Backup e Restauração da Base de Dados
Para salvar um backup da base de dados:

bash
Copiar código
pg_dump -cC --inserts -U freecodecamp number_guess > number_guess.sql
Para restaurar o backup:

bash
Copiar código
psql -U postgres < number_guess.sql
Exemplo de Uso
bash
Copiar código
$ ./number_guess.sh
Enter your username:
> jorge
Welcome back, jorge! You have played 3 games, and your best game took 5 guesses.
Guess the secret number between 1 and 1000:
> 500
It's lower than that, guess again:
> 250
It's higher than that, guess again:
> 375
You guessed it in 3 tries. The secret number was 375. Nice job!
Estrutura de Arquivos
text
Copiar código
number_guessing_game/
├── number_guess.sh         # Script principal do jogo
├── README.md               # Documentação do projeto
└── number_guess.sql        # Backup da base de dados
Mensagens de Commit
Initial commit: Commit inicial com a estrutura básica do projeto.
feat: add database connection and user data handling: Adiciona a conexão com a base de dados e manipulação dos dados do usuário.
feat: add number guessing logic and feedback loops: Implementa a lógica de adivinhação e loops de feedback.
fix: handle non-integer inputs for guesses: Corrige o tratamento de inputs que não são inteiros.
feat: add update mechanism for games played and best game: Adiciona a atualização do número de jogos e a melhor pontuação.
Licença
Este projeto é de uso educacional para o curso do FreeCodeCamp. Consulte os termos de uso do FreeCodeCamp para mais detalhes.
