#!/bin/sh
# Get the current working directory
currentDirectory=$(pwd)
url="https://raw.githubusercontent.com/yinghaoz1/tmdb-movie-dataset-analysis/master/tmdb-movies.csv"

output="$currentDirectory/resource/data.csv"
lib="/lib/"
result="$currentDirectory/result/"
wget=/usr/bin/wget

#echo Downloading $url...
#wget -O $output $url
wget "https://raw.githubusercontent.com/yinghaoz1/tmdb-movie-dataset-analysis/master/tmdb-movies.csv"
