#!/bin/bash


des="${1:?des is required!}"
url="${2:?url is required}"

echo "$url-------->$des"
wget -q -r -np -N "$url" -P "$des"
