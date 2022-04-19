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

#create datasets with selected columns: 1) ("Year", "NestID", "Mass") 2) ("NestID", "Latitude", "Longitude").

#1
Year_ID_Mass = csv_sampling%>% select(Year, NestID, Mass) #Year that a specific nest was observed to be used

#2
Location_ID = csv_locationid%>% select(Latitude, Longitude, NestID) #The GIS co-ordinates of each nest


#Joining dataframe
Joined = Year_ID_Mass %>% left_join(Location_ID, by = "NestID")
Joined$Year <- as.factor(Joined$Year)

Avemass = Joined %>% group_by(Year)%>%summarize(`Average Mass`= mean(Mass,na.rm=TRUE), `Count` = length(Year)) #Variables I need to plot below

# 3) Plotting 

#Plotting 1) the number of tagged chicks per year, and 2) the average chick mass per year

#1
plot_avemass = plot(Avemass$Year, Avemass$`Average Mass`, xlab = "Year", ylab = "Average Chick Mass (g)", main = "Graph showing average mass of Starling chicks per year (2017 - 2022)")

#2
plot_count = plot(Avemass$Year, Avemass$Count, xlab = "Year", ylab = "Number of chicks tagged", main = "Graph showing number of tagged Starling chicks per year (2017 - 2022)")



