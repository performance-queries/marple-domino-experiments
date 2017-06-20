#! /bin/bash
for f in `ls ~/marple/example_queries/*`; do
  cat $f | java -ea -jar ~/marple/target/Compiler-jar-with-dependencies.jar > /dev/null 2>&1
  echo -e "\n" 
  echo "Trying $f with mul_acc"
  ./compile.sh domino-full.c mul_acc.sk 15 15 > /tmp/current.txt
  if [[ $? -eq 0 ]] ; then
    echo "mul_acc succeeded."
    cat /tmp/current.txt
    mv /tmp/pipeline.png figures/`echo ${f} | rev | cut -d '/' -f1 | rev | cut -d '.' -f 1`_mul_acc.png
  else
    echo "mul_acc failed. Trying $f with nested_ifs."
    ./compile.sh domino-full.c nested_ifs.sk 15 15 > /tmp/current.txt
    if [[ $? -eq 0 ]] ; then
      echo "nested_ifs succeeded."
      cat /tmp/current.txt
      mv /tmp/pipeline.png figures/`echo ${f} | rev | cut -d '/' -f1 | rev| cut -d '.' -f 1`_nested_ifs.png
    else
      echo "nested_ifs failed as well."
    fi
  fi
done
