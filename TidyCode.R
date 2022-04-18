# Sabrina Roberts RBRSAB001 2022/04/06.
# Project Title: UCT Starling Project


# 1) Set up:

#Packages
install.packages("tidyverse", "dplyr")
library(tidyverse, dplyr)
library(dplyr)

#Read in data
detach(alldat)
alldat<- read.csv("./Data/Raw/SamplingData.csv", header=T, sep = ",", dec = "." ,stringsAsFactors = TRUE)
attach(alldat)
Location<- read.csv("./Data/Raw/NestLocations.csv", header=T, sep = ",", dec = "." ,stringsAsFactors = TRUE)
attach(alldat)
attach(Location)

# 2) Tidy:

#create datasets with selected columns 1) ("Year", "Nest ID") 2) "NestID", "Latitude", "Longitude").
#1
Year_ID = alldat%>% select(Year, Nest.ID)
#2
Location_ID = Location%>% select(Latitude, Longitude, NestID)


