#!/bin/bash

currentDirectory=$(pwd)
url="https://raw.githubusercontent.com/yinghaoz1/tmdb-movie-dataset-analysis/master/tmdb-movies.csv"
output="$currentDirectory/resource/data.csv"
lib="$currentDirectory/lib"
result="$currentDirectory/result"

cd "$currentDirectory/resource"
rm -rf *

echo "Downloading $url..."
"$lib/wget" "$url" -O "$output"

cd "$result"
rm -rf *

# 1. Sort movies by release date in descending order and save to a new file
csvsort -r -c 16 "$output" > "$result/Project_03_1.csv"
# 2. Filter movies with an average rating above 7.5 and save to a new file
csvsql --query "select * from data where vote_average > 7.5" "$output" > "$result/Project_03_2.csv"
# 3. Find movies with the highest and lowest adjusted revenue
csvsql --query "select * from data where revenue_adj = (select max(revenue_adj) from data) or revenue_adj = (select min(revenue_adj) from data)" "$output" > "$result/Project_03_3.csv"
# 4. Calculate the total revenue of all movies
csvsql --query "select sum(revenue_adj) from data" "$output" > "$result/Project_03_4.csv"
# 5. Top 10 movies with the highest revenue
csvsql --query "select * from data order by revenue_adj desc limit 10" "$output" > "$result/Project_03_5.csv"
# 6. Directors with the most movies and actors with the most appearances
csvsql --query "select * from data order by revenue_adj desc limit 10" "$output" > "$result/Project_03_6.csv"
# 7. Count movies by genre
csvtool -t ',' col 6,14 "$output" | sed 's/, /,/g' | awk -F',' '{split($2, genres, "|"); for(i in genres) print $1 "," genres[i]}' > "$result/Project_03_7_1.csv"
csvsql --query "select genres, count(genres) from Project_03_7_1 group by genres" "$result/Project_03_7_1.csv" > "$result/Project_03_7_2.csv"

echo "Script execution completed. Press Enter to continue..."
read -r
