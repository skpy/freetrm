#!/bin/bash
COUNT=1;
while IFS= read -r line; do
  printf -v NUM "%03d" $COUNT
  NAME=$(echo $line | cut -d \| -f 1);
  DATES=$(echo $line | cut -d \| -f 2);
  LABEL=$(echo $line | cut -d \| -f 3);
  DEETS=$(echo $line | cut -d \| -f 4);
  magick -background white -fill black -size 775x125 -gravity north caption:"${NAME}" one.png
  magick -background white -fill black -size 775x75 -gravity north caption:"${DATES}\n${LABEL}" two.png;
  magick one.png two.png -append header.png
  magick -gravity south -fill black -size 775x260 caption:"${DEETS}" footer.png;
  magick convert bg.png header.png -gravity north -composite footer.png -gravity south -composite person-${NUM}.png
  rm one.png two.png header.png footer.png
  ((COUNT+=1));
done < inventors.txt
