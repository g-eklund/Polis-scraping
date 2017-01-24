#Joining and adding features to data 


Sys.setenv(LANG = "en")
setwd("C:/Users/gustav.eklund/Data_Science/R/Testlab/Environments/Polisen_3")
sss <-read.table("./filename.txt")
filename_history <- as.character(sss[1,1])
rm(sss)
master.frame <- read.csv(filename_history,header =TRUE, sep =",",stringsAsFactors = TRUE)
master.frame <- master.frame[-grep("Sammanfattning", master.frame$EventCategory),]
if (ncol(master.frame == 10)){master.frame$X <- NULL}

library(dplyr)

#adding salary cond.
master.frame.sal              <- cbind.data.frame(master.frame$ID, paste(master.frame$EventWeekday, master.frame$EventDay))
weekdays_calculator           <- read.csv("weeks_payday2.csv", header = TRUE, sep = ";" )  #Necessary file
colnames(weekdays_calculator) <- c("EventDay", "EventWeekday", "SalaryIndicator")
weekdays_calculator           <- cbind.data.frame(weekdays_calculator$SalaryIndicator,paste(weekdays_calculator$EventWeekday, weekdays_calculator$EventDay))
colnames(weekdays_calculator) <- c("SalaryIndicator", "EventInd")
colnames(master.frame.sal)    <- c("ID", "EventInd")
weekdays_calculator$EventInd  <- as.character(weekdays_calculator$EventInd)
master.frame.sal$EventInd     <- as.character(master.frame.sal$EventInd)
master.frame.salary           <- left_join(master.frame.sal, weekdays_calculator, by = "EventInd")
SalaryIndicator               <- master.frame.salary$SalaryIndicator
master.frame                  <- cbind.data.frame(master.frame, SalaryIndicator)
rm(master.frame.sal, master.frame.salary, weekdays_calculator, SalaryIndicator)

#adding Lan 

area.data                     <- read.table("Kommun_lan_hierarki.csv", header =TRUE, sep =";")
area.data$EventArea           <- as.character(area.data$EventArea)
area.data$LanNamn             <- as.character(area.data$LanNamn)
master.frame$EventArea        <- as.character(master.frame$EventArea)
master.frame.area             <- left_join(master.frame,area.data, by = "EventArea")
master.frame                  <- distinct(master.frame.area, ID, .keep_all = TRUE)
rm(master.frame.area, area.data)


#adding crime category 2

category_data                 <- read.table("Crimes_categories.csv", header =TRUE, sep =";")
colnames(category_data)       <- c("EventCategory", "EventCategory2")
category_data$EventCategory   <- as.character(category_data$EventCategory)
master.frame$EventCategory    <- as.character(master.frame$EventCategory)
master.frame.crimecat         <- left_join(master.frame,category_data, by = "EventCategory")
master.frame                  <- master.frame.crimecat
rm(category_data,master.frame.crimecat)

# Adding a column with 1's
ones <- as.data.frame(rep(1,nrow(master.frame)))
colnames(ones) <- "Count"
mas <- cbind(master.frame, ones)
master.frame <- mas
rm(temp_table,old_data,total_events,list_events, master_table,mas,ones)
rm(i,pages)

#Joining population
hepp <- read.csv("hepp2.csv")
heppinv <- as.data.frame(cbind(hepp$KommunKod, 1000/hepp$AntalGiftaKvinnor, 1000/hepp$AntalGiftaMan, 1000/hepp$AntalOgiftaKvinnor, 1000/hepp$AntalOgiftaMan, 1000/hepp$AntalSkildaKvinnor, 1000/hepp$AntalSkildaMan, 1000/hepp$Ankor, 1000/hepp$Anklingar))
colnames(heppinv) <- colnames(hepp)
master.frame.population <- left_join(master.frame, hepp, by = "KommunKod" )
master.frame.population_inv <- left_join(master.frame, heppinv, by = "KommunKod" )



#stop("fuck it")


# adding weather?
#library(httr)

#url1 <- "http://opendata-download-metobs.smhi.se/api/version/"
#version <- "1.0"
#url2 <- "/parameter/"
#param <- 1
#url3 <- "/station/"
#station <- "159880"
#url4 <- "/period/"
#period <-"corrected-archive"
#url5 <- "/data.csv"
#API.url <- paste(url1,version,url2,param,url3,station,url4,period,url5, sep = "")

#test <- read.csv(API.url)

#urk <-content(test, "text", encoding = "ISO-8859-1")
#urk

#hej <-unlist(strsplit(urk, "\n"))
#svej <- unlist(strsplit(hej, ";"))
