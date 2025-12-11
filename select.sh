#!/bin/bash

htmldir="/Users/$(whoami)/Sites/html"
txtdir="/Users/$(whoami)/Sites/txt"
oodham_corpus_texts="/Users/$(whoami)/desktop/o'odham_corpus_texts"

mkdir -p "$htmldir" "$txtdir"
mkdir -p "$oodham_corpus_texts"

directtosites () {
    base="$(basename "$TEXT" .txt)"
    out_html="${htmldir}/${base}.html"

    printf "<!DOCTYPE html> \n <meta charset=\"utf-8\"> \n <html> \n <h1>$base</h1> \n <body><pre> \n " > "$out_html"
    cat "$TEXT" >> "$out_html"
    printf "</body> \n </html>" >> "$out_html"

    exit 0
}

main () {
echo "Content-Type: text/plain"
echo 'Please select a file.'

n=0

for txt in "$txtdir"/*.txt
do
    n=$((n+1))
    printf "[%s] %s\n" "$n" "$txt"
    eval "txt${n}=\$txt"
done

if [ "$n" -eq 0 ]
then
    echo >&2 No text found.
    exit
fi

printf 'Enter File Index ID (1 to %s): ' "$n"
read -r num
num=$(printf '%s\n' "$num" | tr -dc '[:digit:]')

if [ "$num" -le 0 ] || [ "$num" -gt "$n" ]
then
    echo >&2 Wrong selection.
    exit 1
else
    eval "TEXT=\$txt${num}"
    echo Selected text is "$TEXT"
fi


read -p "Enter orthographic change: SaxtonToAlvarez (a), AlvarezToSaxton (b), or neither (c): " orthoch

case "$orthoch" in
    a) orthoch="SaxtonToAlvarez";;
    b) orthoch="AlvarezToSaxton";;
    c) directtosites ;;
    *) echo "Invalid Selection" ; exit 1;;
esac

read -p "What do you want to call the new file? " newfile

LC_ALL=C LANG=C "/Users/$(whoami)/Desktop/tohelper" "-${orthoch}" "$TEXT" "${newfile}.txt"

cp "${newfile}.txt"  "$txtdir/"

out_html="${htmldir}/${newfile}.html"
php "/Users/$(whoami)/Sites/dualtext.php" "$TEXT" "${newfile}.txt" > "$out_html"
mv "${newfile}.txt"  ""$oodham_corpus_texts""
}

read -p "Is the file a PDF on the desktop? yes/no: " format
if 
    [ "$format" = no ]; 
then
    main
elif [ "$format" = yes ]; 
then
    read -p 'What is the file called? ' pdfname
    /opt/homebrew/bin/pdftotext '-enc' 'UTF-8' '-layout' "${pdfname}.pdf" "${pdfname}.txt"

    mv "${pdfname}.txt" "$txtdir/"

    main
else
    echo 'Please check the name of your file';
    exit 1
fi