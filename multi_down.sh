#!/bin/bash

link="${1:?link is required!}"
des="${2:?des is required!}"

echo $link
if [ "$link" == "" ];
then
   exit 2 
fi

file="index.html"
bak_file="bak_$file"
i=0

# rm all html
rm -f *.html

# get index.html
wget $link -O $file
# if the link is https..........

cat $file > $bak_file

# add \n before < and >
sed -i -e 's/</\n</g' $bak_file
sed -i -e 's/>/\n>/g' $bak_file

# grep "href" "<a" "/$"
# cut "\""
url_list=`cat $bak_file | grep "href*=*\"" | grep "<a" | cut -d "\"" -f 2 | grep "/$" | grep -v "\.\."`

for url in $url_list
do
    whole_url_list[$i]="$link$url"
    i=`expr $i+1`
done

echo ${whole_url_list[@]} | xargs -n 1 -P 8 ./single_down.sh "$des"
