#! /bin/bash

for file in $(ls)
do
    if [${file} != "presentation.pdf" | ${file} != "diplom.pdf"]
    rm -r ${file}
done
