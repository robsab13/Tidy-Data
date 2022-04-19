# Sabrina Roberts RBRSAB001 2022/04/06.
# Project Title: UCT Starling Project

# 1) Set up:

#Packages
install.packages("tidyverse", "dplyr")
library(tidyverse)
library(dplyr)

#Read in .csv data
csv_sampling<- read.csv("./Data/Raw/SamplingData.csv", header=T, sep = ",", dec = "." ,stringsAsFactors = TRUE)
csv_locationid<- read.csv("./Data/Raw/NestLocations.csv", header=T, sep = ",", dec = "." ,stringsAsFactors = TRUE)

# 2) Tidying:

#create data sets with selected columns: 1) ("Year", "NestID", "Mass") 2) ("NestID", "Latitude", "Longitude").

#1
Year_ID_Mass = csv_sampling%>% select(Year, NestID, Mass) #Year that a specific nest was observed to be used

#2
Location_ID = csv_locationid%>% select(Latitude, Longitude, NestID) #The GIS co-ordinates of each nest


#Joining dataframe so all info is in 1
Joined = Year_ID_Mass %>% left_join(Location_ID, by = "NestID")
Joined$Year <- as.factor(Joined$Year)


# 3) Plot

#Plotting 1) the number of tagged chicks per year, and 2) the average chick mass per year

#1
#2022 will be excluded as the data has not run for a full year yet
Joined0 <- Joined[Joined$Year != "2022",]
Joined0$Year <- as.character(Joined0$Year)
Joined0$Year <- as.factor(Joined0$Year)

plot(Joined0$Year, Joined0$Mass, xlab = "Year", ylab = "Chick Mass (g)", main = "Graph showing mass of Starling chicks per year (2017 - 2021)")

#2
Avemass = Joined0 %>% group_by(Year)%>%summarize(`Average Mass`= mean(Mass,na.rm=TRUE), `Count` = length(Year)) #Variables I need so I can plot below

plot_count = plot(Avemass$Year, Avemass$Count, xlab = "Year", ylab = "Number of chicks tagged", main = "Graph showing number of tagged Starling chicks per year (2017 - 2021)")

# 4) Testing Significance

#including 2022 - significance
m1<-aov(Joined$Mass~Joined$Year)
summary(m1)
TukeyHSD(m1)

#excluding 2022 - no significance
m2<-aov(Joined0$Mass~Joined0$Year)
summary(m2)
TukeyHSD(m2)
