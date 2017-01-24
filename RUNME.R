#factominerR


rm(list=ls(all=TRUE)) 
Sys.setenv(LANG = "en")

setwd("C:/Users/gustav.eklund/Data_Science/R/Testlab/Environments/Polisen_3")
source("010_root_scraper_current_data.R")
source("013_Joining_categories.R")

#master.frame.population <- master.frame.population[-grep("Trafikolycka", master.frame$EventCategory),]
#master.frame.population <- master.frame.population[-grep("Rattfylleri", master.frame$EventCategory),]

write.table(master.frame.population, "Polisdata170117_pop.csv", row.names = FALSE, sep =";")

write.table(master.frame.population_inv, "Polisdata120117_inv.csv", row.names = FALSE, sep = ";")

# SQL SERVER 

library(RODBC)
Conn <- odbcConnect('LocalDB')
#data <- RODBC::sqlQuery(Conn, "select top 10 * from [dbo].[reading_of_polisen13117]")
sqlSave(Conn,master.frame,tablename = "Police3", rownames = T)
sqlUpdate(Conn,master.frame,tablename = "Police3")
odbcClose(Conn)


# analysis
Main.data <- master.frame.population
library(dplyr)
library(tidyr)
library(ade4)
library(dummies)
library(caret)
library(mlbench)




