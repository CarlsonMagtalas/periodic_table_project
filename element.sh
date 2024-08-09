PSQL="psql -X -U freecodecamp --dbname=periodic_table -t -c"

if [[ $1 ]]
then
  ELEMENT_DETAILS=$($PSQL "SELECT elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties ON elements.atomic_number=properties.atomic_number INNER JOIN types ON properties.type_id=types.type_id WHERE elements.atomic_number::text='$1' OR name='$1' OR symbol='$1'")
  if [[ -z $ELEMENT_DETAILS ]]
  then
  echo "I could not find that element in the database."
  else
    echo "$ELEMENT_DETAILS" | while read ID BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELT BAR BOIL BAR
    do
      echo "The element with atomic number $ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
else
  echo "Please provide an element as an argument."
fi