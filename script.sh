#!/bin/bash

if [ ! -d done ]
then
	mkdir ./done
	echo "Neuen Ordner erstellt"
else
	rm ./done/*
	echo "alte Dateien gelöscht"
fi
convert -monitor -resize 100x Logo-ohne-BRG-klein.png ./done/logo.png
a=1
for i in *.JPG
do
	echo "./neu/Bild_$a.jpg"
	convert -monitor -caption '%f' -resize 640x $i  \
		-gravity SouthEast ./done/logo.png -geometry +15+15 \
		-composite \
			-bordercolor snow -background black \
			 -gravity center -font 'Liberation Sans' -pointsize 26 \
		+polaroid \
		./done/2008-­Sanierung-­$a.png
	((a++))
done
