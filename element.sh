# Made by marooned13371

# Postgres Queries to database
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
# Posicional parameter, number one
QUERY=$1
# If the user input a parameter, the script will go to the else block
if [[ $# -eq 0 ]]; then
    echo "Please provide an element as an argument."
  else
    if ! [[ $QUERY =~ ^[0-9]+$ ]]; then
        VAL=$(echo -n "$QUERY" | wc -m)
                if [[ $VAL -gt 2 ]]; then
            # If the word has 2 or more characters, go to this block
            CONTENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$QUERY'")
            if [[ -z $CONTENT ]]; then
                echo "I could not find that element in the database."
            else
                echo "$CONTENT" | while IFS="|" read TYPE_ID NUMBER SYMBOL NAME WEIGHT MELTING BOILING TYPE; do
                  echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
                done
            fi
        else
            CONTENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$QUERY'")
            if [[ -z $CONTENT ]]; then
                echo "I could not find that element in the database."
            else
                # If the word is a symbol (have 2 or 1 char), go to this block
                echo "$CONTENT" | while IFS="|" read TYPE_ID NUMBER SYMBOL NAME WEIGHT MELTING BOILING TYPE; do
                echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
              done
            fi
        fi
    else
            # If the parameter is a number, go to this block
        CONTENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number='$QUERY'")
        if [[ -z $CONTENT ]]; then
            echo "I could not find that element in the database."
        else
            echo "$CONTENT" | while IFS="|" read -r TYPE_ID NUMBER SYMBOL NAME WEIGHT MELTING BOILING TYPE; do
              echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
          done
        fi
    fi


fi


