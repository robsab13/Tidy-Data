# Sabrina Roberts RBRSAB001 2022/04/06.
# Project Title: UCT Starling Project

# 1) Set up:

#Packages
#install.packages("tidyverse", "dplyr")
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

# 4) Testing Significance of average chick mass and year

#including 2022 - significance
m1<-aov(Joined$Mass~Joined$Year)
summary(m1)
TukeyHSD(m1)

#excluding 2022 - no significance
m2<-aov(Joined0$Mass~Joined0$Year)
summary(m2)
TukeyHSD(m2)

#--------MAPPING:

# Packages:
library(sf)
# install.packages("rosm")
# install.packages("ggspatial")
library(rosm)
library(ggspatial)

# Optimizing data:
GISDataset <- na.omit(Joined0)
write.csv(GISDataset,"./Data/Clean/GISDataset.csv", row.names = TRUE)#csv of dataset
#I convert the csv to .shp using https://mygeodata.cloud/converter/csv-to-shp
dat <- st_read("./Data/SHP/GISDataset-point.shp") #read in .shp
dat$Mass = NULL # rm mass column

# select only year 2019 and 2021
split_dat <- c("2019", "2021")
dat <- dat[which(dat$Year %in% split_dat),]

#more specific:
split_dat_2019 = c("2019")  #pre covid data
dat2019 <- dat[which(dat$Year %in% split_dat_2019),]
split_dat_2021 = c("2021")  #during covid data
dat2021 <- dat[which(dat$Year %in% split_dat_2021),]

#remove dupliactes 2019
dat2019 = dat2019[!duplicated(dat2019$NestID),]
#remove dupliactes 2021
dat2021 = dat2021[!duplicated(dat2021$NestID),]


#plot

#ggplot() + geom_sf(data=dat, aes(fill = "Year"))
#ggplot() + annotation_map_tile(type = "osm", progress = "none") + geom_sf(data=dat)

#Interactive map
#install.packages("leaflet")
#installed.packages("htmltools")
library(leaflet)
library(htmltools)
leaflet() %>%
  # Add default OpenStreetMap map tiles
  addTiles(group = "Default") %>%  
  # Add our points
  addCircleMarkers(data = dat2019,
                   group = "Year",
                   radius = 4, 
                   color = "blue") %>%
  addCircleMarkers(data = dat2021,
                 group = "Year",
                 radius = 2, 
                 color = "red")
