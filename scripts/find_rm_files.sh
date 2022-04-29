#! /bin/bash

for file in $(ls)
do
    if "$file" != "presentation.pdf" | "$file" != "diplom.pdf"
    then
        rm -r $file
    fi
done
