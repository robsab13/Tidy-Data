# Sabrina Roberts RBRSAB001 2022/04/06.
# Project Title: UCT Starling Project


#-Set up-

#Packages
install.packages(c("tidyverse", "sp", "rgdal", "raster", "sf", "lwgeom", "terra", "stars", "exactextractr"))

#Directory
#Change to where the files are stored
setwd("C:/Users/Sabrina/Desktop/STUDIES/GIS Project and Tidy Data/Data/Clean")
getwd()

dat = read.csv("Location_ID_StarlingChicks.csv", header=T, sep = ",", dec = ". ,stringsAsFactors = TRUE)
dat
attach(dat)
head(dat)

#Code

