#! /bin/bash
rm -rf mul_acc.txt
rm -rf nested_ifs.txt
for f in `ls marple/example_queries/*`; do
  echo "Now running $f"
  cat $f | java -ea -jar marple/target/Compiler-jar-with-dependencies.jar > /dev/null 2>&1

  echo $f >> mul_acc.txt
  ./compile.sh domino-full.c mul_acc.sk    15 15 >> mul_acc.txt
  echo -e "\n" >> mul_acc.txt
  mv /tmp/pipeline.png `echo ${f} | cut -d '/' -f 3 | cut -d '.' -f 1`_mul_acc.png

  echo $f >> nested_ifs.txt
  ./compile.sh domino-full.c nested_ifs.sk 15 15 >> nested_ifs.txt
  echo -e "\n" >> nested_ifs.txt
  mv /tmp/pipeline.png `echo ${f} | cut -d '/' -f 3 | cut -d '.' -f 1`_nested_ifs.png

done
