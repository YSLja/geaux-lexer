#!/bin/bash
export CLASSPATH=$CLASSPATH:$(pwd)
export CLASSPATH=$CLASSPATH:$(pwd)/.solution/
export CLASSPATH=$CLASSPATH:$(pwd)/bin/
export CLASSPATH=$CLASSPATH:$(pwd)/lib/*

testfiles=($(find ./tests/ -type f))
       echo "################################################################################" > report.txt
       for testfile in "${testfiles[@]}"; do
         # Generate report
         echo "################################################################################" >> report.txt
         cat $testfile >> report.txt
         echo "" >> report.txt
         echo "" >> report.txt
         echo $testfile >> report.txt
         ./run.sh $testfile >> report.txt 2>&1
       done

testfiles=($(find ./tests/ -type f))
       echo "################################################################################" > solution_report.txt
       for testfile in "${testfiles[@]}"; do
         # Generate report
         echo "################################################################################" >> solution_report.txt
         cat $testfile >> solution_report.txt
         echo "" >> solution_report.txt
         echo "" >> solution_report.txt
         echo $testfile >> solution_report.txt
         ./run_solution.sh $testfile >> solution_report.txt 2>&1
       done

diff -u report.txt solution_report.txt >> final_report.txt
