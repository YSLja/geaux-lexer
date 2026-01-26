export CLASSPATH=$CLASSPATH:$(pwd)
export CLASSPATH=$CLASSPATH:$(pwd)/bin/
export CLASSPATH=$CLASSPATH:$(pwd)/lib/*

make clean

java -jar ./lib/antlr-4.13.2-complete.jar Parse/gLexer.g4 -o ./Parse/antlr_build

find . -name "*.java" > sources.txt
javac -d bin @sources.txt

rm sources.txt

if [ "$#" -eq 0 ]; then
   java Parse.LexerDriver test.g
else
   java Parse.LexerDriver $1
fi 
