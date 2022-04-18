# Sabrina Roberts RBRSAB001 2022/04/06.
# Project Title: UCT Starling Project


# 1) Set up:

#Packages
install.packages(c("tidyverse", "sp", "rgdal", "raster", "sf", "lwgeom", "terra", "stars", "exactextractr", "readr", "readxl"))
library(tidyverse, readr)

#Read in data
dat<- read.csv("./Data/Clean/Location_ID_StarlingChicks.csv", header=T, sep = ",", dec = "." ,stringsAsFactors = TRUE)
attach(dat)


# 2) Tidy:


