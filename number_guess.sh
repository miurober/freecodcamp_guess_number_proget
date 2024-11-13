#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\n~~~~~ Number Guessing Game ~~~~~\n" 
echo "Enter your username:"
read USERNAME

# Verifica se o utilizador já existe no banco de dados
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

if [[ -z $USER_ID ]]; then
  # Usuário não existe, então insere no banco de dados
  INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
else
  # Usuário já existe, recupera dados de jogos jogados e melhor pontuação
  GAME_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id = $USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(number_guesses) FROM games WHERE user_id = $USER_ID")
  
  echo  "Welcome back, $USERNAME! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Geração de número aleatório entre 1 e 1000
RANDOM_NUM=$((1 + $RANDOM % 1000))
GUESS=0

# Solicita adivinhar o número até acertár
echo -e "\nGuess the secret number between 1 and 1000:"
while read NUM; do
# Verifica se a entrada é um número inteiro
if [[ ! $NUM =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
  else
    # Incrementa o contador de tentativas
    GUESS=$((GUESS + 1))

    # Verifica se o número está correto
    if [[ $NUM -eq $RANDOM_NUM ]]; then
      echo -e "\nYou guessed it in $GUESS tries. The secret number was $RANDOM_NUM. Nice job!"
      # Insere o jogo no banco de dados
      INSERT_GAME=$($PSQL "INSERT INTO games(number_guesses, user_id) VALUES($GUESS, $USER_ID)")
      break  # Sai do loop quando o número é adivinhado
    elif [[ $NUM -gt $RANDOM_NUM ]]; then
      echo "It's lower than that, guess again:"
    else
      echo "It's higher than that, guess again:"
    fi
  fi
done
