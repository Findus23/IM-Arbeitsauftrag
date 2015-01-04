#!/bin/bash

if [ ! -d done ]
then
	mkdir ./done
	echo "Neuen Ordner erstellt"
else
	rm ./done/*
	echo "alte Dateien gelöscht"
fi
format=$(zenity --entry --text "Welches Dateiformat soll ausgegeben werden?" --title "Dateiformat") || exit 1
if [ -z $format ] # keine Eingabe
then
	format="png"
fi

name=$(zenity --entry --text "Welchen  Namen sollen die Dateien haben?" --title "Dateiname") || exit 1
if [ -z $name ]
then
	name="2008­-Sanierung­-"
fi

echo "Logo wird verkleinert"
convert -monitor -resize 100x Logo-ohne-BRG-klein.png ./done/logo.png

a=1
for i in *.JPG
do

	a_f="$(printf "%02d" $a)"
	echo "--------------./done/2008-­Sanierung-­$a.png------------------"
	convert -monitor -caption '%f' -resize 640x $i  \
		-gravity SouthEast ./done/logo.png -geometry +15+15 \
		-composite \
			-bordercolor snow -background black \
			 -gravity center -font Liberation-Sans -pointsize 26 \
		+polaroid \
		./done/$name­$a_f.$format
	((a++))
done
rm ./done/logo.png
montage -monitor  -label '%f\n%wx%h' -geometry '300x+5+5' ./done/*.$format -caption '%f\n%wx%h' -font Liberation-Sans -pointsize 20 -background transparent -frame 5 ./done/Thumbnails.$format

zenity --info --text "Das Programm ist fertig." --title "Fertig"
