# !/bin/bash -eu

while read unmapped
do
  NAME=$(echo "${unmapped}" | cut -f1)
  SEQUENCE=$(echo "${unmapped}" | cut -f10)
  echo -e ">${NAME}\n${SEQUENCE}"
done <<< "$(samtools view -f4 $1)"


