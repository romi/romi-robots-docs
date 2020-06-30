#!/bin/sh

# Should be run from the directory containing the *.gv files to convert to *.svg

for g in ./*.gv
do
  echo $g
  DIR=$(dirname "${g}")
  name=${g##*/}
  base=${name%.gv}
  echo $DIR/../images/$base.svg
  dot -Tsvg $g -o $DIR/../images/$base.svg
done;
