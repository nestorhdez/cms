# !/bin/sh

INDEX=1
TOTAL_FILES="$(find ./posts -maxdepth 1 -type f | wc -l)"
OUTPUT="./posts.json"

echo "{"$'\n'\"posts\"": [" > $OUTPUT

for file in ./posts/blog/*.json; do

  cat $file >> $OUTPUT

  if [[ INDEX -lt TOTAL_FILES ]]; then
    echo "," >> $OUTPUT
    ((INDEX++))
  fi
  
done

echo $'\n'"]"$'\n'"}" >> $OUTPUT

echo $TOTAL_FILES files merged.
