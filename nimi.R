#install.packages("ggplot2")
library(ggplot2)
#install.packages("devtools")
library("devtools")
#install_github("RRisto/riigiteenused")
library(riigiteenused)
#install.packages("rjson")
library(rjson)
x=andmedSisse("https://www.riigiteenused.ee/api/et/all")

#install.packages("dplyr")
library("dplyr")

#install.packages("reshape2")
library(reshape2)
toetus = read.csv2("./Data/toetuse_saajad.csv")

#install.packages("rvest")
library(rvest)