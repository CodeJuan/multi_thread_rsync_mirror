#!/bin/bash

link="${1:?link is required!}"

file="index.html"
bak_file="bak_$file"

# rm all html
rm -f *.html

# get index.html
wget $link -O $file

cat $file | grep "<a" > $bak_file

sed -i -e 's/</\n</g' $bak_file
sed -i -e 's/>/\n>/g' $bak_file

