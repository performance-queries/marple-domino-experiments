#! /bin/bash
#Change this examples variable to run a different set of examples
examples="pkt_counts latency_ewma tcp_oos tcp_nmo flowlet_hist paper_high_e2e_latency paper_new_connections incast paper_loss_rate paper_tcp_timeouts"
rm -rf figures/*.png
for example in $examples; do
  f=~/marple/example_queries/$example.sql
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
