# !/bin/sh

BASE=$(pwd)
PROJECT=${PWD##*/}

echo $BASE
echo $PROJECT

INDEX=1
INPUT="./posts/blog/*.json"
TOTAL_FILES="$(find $INPUT -maxdepth 1 -type f | wc -l)"
OUTPUT="./posts/blogs.json"

echo "{"$'\n'\"posts\"": [" > $OUTPUT

for file in $INPUT; do

  cat $file >> $OUTPUT

  if [[ INDEX -lt TOTAL_FILES ]]; then
    echo "," >> $OUTPUT
    ((INDEX++))
  fi
  
done

echo $'\n'"]"$'\n'"}" >> $OUTPUT

echo $TOTAL_FILES files merged.
