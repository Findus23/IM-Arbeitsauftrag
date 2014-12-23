#!/bin/bash

if [ ! -d done ]
then
	mkdir ./done
	echo "Neuen Ordner erstellt"
else
	rm ./done/*
	echo "alte Dateien gelöscht"
fi

a=1
for i in *.JPG
do
	echo "./neu/Bild_$a.jpg"
	convert -monitor -resize 640x640 $i ./done/2008-­Sanierung-­$a.png
	((a++))
done
