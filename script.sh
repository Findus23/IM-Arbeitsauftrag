#!/bin/bash

TEXTDOMAIN=script
TEXTDOMAINDIR=./

if [ ! -d done ]
then
	mkdir ./done
	echo $"created new folder"
else
	rm ./done/*
	echo $"deleted old files"
fi

format=$(zenity --entry --text $"What is the export file format?" --title $"file format") || exit 1
if [ -z $format ] # keine Eingabe
then
	format="png"
fi

name=$(zenity --entry --text $"How should the files be named?" --title $"file name") || exit 1
if [ -z $name ]
then
	name="2008­-Sanierung­-"
fi

echo $"resizing Logo"
convert -monitor -resize 100x Logo-ohne-BRG-klein.png ./done/logo.png

a=1
exec 3> >(zenity --progress --title=$"converting..." --percentage=0 --width=400)
echo $"# determining files..." >&3
dateien=(*.JPG)
dateianzahl=${#dateien[@]}
for i in ${dateien[@]}
do
	echo $"# converting '$i'... ($a out of $dateianzahl)" >&3;
	a_f="$(printf "%02d" $a)" # Darstellung mit führender Null
	convert -monitor -caption '%f' -resize 640x $i  \
		-gravity SouthEast ./done/logo.png -geometry +15+15 \
		-composite \
			-bordercolor snow -background black \
			 -gravity center -font Liberation-Sans -pointsize 26 \
		+polaroid \
		./done/$name­$a_f.$format
	echo "$a/$dateianzahl*100" | bc -l >&3
	((a++))
done
rm ./done/logo.png
echo $"# generating thumbnails..." >&3
montage -monitor  -label '%f\n%wx%h' -geometry '300x+5+5' ./done/$name*.$format -caption '%f\n%wx%h' -font Liberation-Sans -pointsize 20 -background transparent -frame 5 ./done/Thumbnails.$format
echo $"# conversion is ready." >&3
notify-send --app-name=imagemagick --icon=imagemagick -t 5000 Imagemagick $"conversion is ready" #im Paket libnotify-bin
