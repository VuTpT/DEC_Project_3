#!/bin/sh
# Remove all files in the folder resource
find resource/*.csv -type f -delete 
# Downloading resources from URL
wget -O resource/data.csv https://raw.githubusercontent.com/yinghaoz1/tmdb-movie-dataset-analysis/master/tmdb-movies.csv 

# 1. Sort movies by release date in descending order and save to a new file
csvsort -r -c 16 resource/data.csv > resource/Project_03_1.csv
# 2. Filter movies with an average rating above 7.5 and save to a new file
csvsql --query "select * from data where vote_average > 7.5" resource/data.csv > resource/Project_03_2.csv
# 3. Find movies with the highest and lowest adjusted revenue
csvsql --query "select * from data where revenue_adj = (select max(revenue_adj) from data) or revenue_adj = (select min(revenue_adj) from data)" resource/data.csv > resource/Project_03_3.csv
# 4. Calculate the total revenue of all movies
csvsql --query "select sum(revenue_adj) from data" resource/data.csv > resource/Project_03_4.csv
# 5. Top 10 movies with the highest revenue
csvsql --query "select * from data order by revenue_adj desc limit 10" resource/data.csv > resource/Project_03_5.csv
# 6. Directors with the most movies and actors with the most appearances
csvsql --query "select * from data order by revenue_adj desc limit 10" resource/data.csv > resource/Project_03_6.csv
# 7. Count movies by genre
csvtool -t ',' col 1,14 resource/data.csv | sed 's/, /,/g' | awk -F',' '{split($2, genres, "|"); for(i in genres) print $1 "," genres[i]}' > resource/Project_03_7_1.csv
csvsql --query "select genres, count(1) total from Project_03_7_1 group by genres" resource/Project_03_7_1.csv > resource/Project_03_7_2.csv

echo "Script execution completed. Press Enter to continue..."



