#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]; then
      # get WINNER_ID
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      # if not found
      if [[ -z $WINNER_ID ]]; then
          INSERT_WINNER_ID=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")

          if [[ $INSERT_WINNER_ID = "INSERT 0 1" ]]; then
              # echo "Inserted into teams, WINNER: $WINNER"
          fi

          WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name ='$WINNER'")
      fi

      

      # get OPPONENT_ID
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
      # if not found
        if [[ -z $OPPONENT_ID ]]; then
          INSERT_OPPONENT_ID=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")

          if [[ $INSERT_OPPONENT_ID = "INSERT 0 1" ]]; then
              # echo "Inserted into teams, OPPONENET: $OPPONENT"
          fi

          OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name ='$OPPONENT'")
      fi


  fi
done
