#!/bin/bash
file=$1
scp "$file" pints@redbrick.dcu.ie:~/public_html/files/"$file"
echo redbrick.dcu.ie/~pints/files/"$file" | xclip && echo redbrick.dcu.ie/~pints/files/"$file"

