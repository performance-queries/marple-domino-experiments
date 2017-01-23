#! /bin/bash
for f in `ls marple/example_queries/*`; do
  cat $f | java -ea -jar marple/target/Compiler-jar-with-dependencies.jar > /dev/null 2>&1
  echo $f > mul_acc.txt
  ./compile.sh domino-full.c mul_acc.sk    15 15 > mul_acc.txt
  echo $f > nested_ifs.txt
  ./compile.sh domino-full.c nested_ifs.sk 15 15 > nested_ifs.txt
done
