# Sabrina Roberts RBRSAB001 2022/04/06.
# Project Title: UCT Starling Project

# 1) Set up:

#Packages
install.packages("tidyverse", "dplyr")
library(tidyverse, dplyr)

#Read in .csv data
csv_sampling<- read.csv("./Data/Raw/SamplingData.csv", header=T, sep = ",", dec = "." ,stringsAsFactors = TRUE)
csv_locationid<- read.csv("./Data/Raw/NestLocations.csv", header=T, sep = ",", dec = "." ,stringsAsFactors = TRUE)

# 2) Tidying:

#create datasets with selected columns: 1) ("Year", "NestID") 2) ("NestID", "Latitude", "Longitude").

#1
Year_ID = csv_sampling%>% select(Year, NestID) #Year that a specific nest was observed to be used

#2
Location_ID = csv_locationid%>% select(Latitude, Longitude, NestID) #The GIS co-ordinates of each nest

#removing duplicates from year_ID. Since this is absence/presence, only one observation per year is needed.

#Joining dataframe

Joined = Year_ID %>% left_join(Location_ID, by = "NestID")

#Delete where NA
CleanedJoined = na.omit(Joined) #11 removed
