#!/bin/bash

if [ ! -d done ]
then
	mkdir ./done
	echo "Neuen Ordner erstellt"
else
	rm ./done/*
	echo "alte Dateien gelöscht"
fi
echo "Logo wird verkleinert"
convert -monitor -resize 100x Logo-ohne-BRG-klein.png ./done/logo.png
a=1
for i in *.JPG
do
	echo "--------------./done/2008-­Sanierung-­$a.png------------------"
	convert -monitor -caption '%f' -resize 640x $i  \
		-gravity SouthEast ./done/logo.png -geometry +15+15 \
		-composite \
			-bordercolor snow -background black \
			 -gravity center -font 'Liberation Sans' -pointsize 26 \
		+polaroid \
		./done/2008-­Sanierung-­$a.png
	((a++))
done
rm ./done/logo.png
montage -monitor  -label '%f\n%wx%h' -geometry '300x+5+5' ./done/*.png -caption '%f\n%wx%h' -font Liberation-Sans -pointsize 20 -background transparent -frame 5 ./done/thumbnails.PNG
