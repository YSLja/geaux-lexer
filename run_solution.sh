export CLASSPATH=$CLASSPATH:$(pwd)
export CLASSPATH=$CLASSPATH:$(pwd)/.solution/
export CLASSPATH=$CLASSPATH:$(pwd)/bin/
export CLASSPATH=$CLASSPATH:$(pwd)/lib/*

if [ "$#" -eq 0 ]; then
   java Parse.SolutionDriver test.g
else
   java Parse.SolutionDriver $1
fi
