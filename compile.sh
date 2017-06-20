#! /bin/bash
if [ $# -ne 4 ]; then
  echo "Usage: ./compile.sh domino_program atom_template pipeline_depth pipeline_width";
  exit;
fi;

domino_program=$1
atom_template=$2
pipeline_depth=$3
pipeline_width=$4

domino $domino_program $atom_template $pipeline_depth $pipeline_width 2> /tmp/error.log > /tmp/out.log

if grep --quiet "exceeds allowed pipeline" /tmp/error.log; then
  echo "Failed to find mapping: pipeline is too small"
  grep "exceeds allowed pipeline" /tmp/error.log
  exit 1
elif grep --quiet "Sketch Not Resolved" /tmp/error.log; then
  echo "Failed to find mapping: atom isn't expressive enough"
#  grep "Sketch failed " /tmp/error.log;
  exit 2
else
  echo "Found a mapping"
  grep "Total of" /tmp/out.log | grep "stages"
  grep "atoms/stage" /tmp/out.log
  grep "Total of" /tmp/out.log | grep "atoms"
  gvpr -f secondgraph.gv /tmp/error.log | neato -n -T png > /tmp/pipeline.png
  echo "Pipeline diagram at /tmp/pipeline.png"
  exit 0
fi
