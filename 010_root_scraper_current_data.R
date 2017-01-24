### Main scrape script current data 

#rm(list=ls(all=TRUE)) 
Sys.setenv(LANG = "en")
setwd("C:/Users/gustav.eklund/Data_Science/R/Testlab/Environments/Polisen_3")
sss <-read.table("./filename.txt")
filename_history <- as.character(sss[1,1])
rm(sss)
#history_data_path <- paste()
library(rvest)
require(rvest)
library(dplyr)
weekdays_calculator <- read.csv("weeks_payday.csv", header = TRUE, sep = ";" )  #Necessary file
source("011_web_scraper.R")
source("012_week_translate.R")
pages <- seq(1,6)
total_events <- NULL
for (i in pages){
  list_events <-web_scraper(i)
  total_events <- rbind(total_events, list_events)
}

total_events <- as.data.frame(total_events)
colnames(total_events) <- c("ID", "EventYear", "EventMonth", "EventDay", "EventWeekday", "EventHour", "EventMinute", "EventArea", "EventCategory")
#cols <-  c(2,3,4,6,7)
#for (i in cols){
#total_events[,i] <- as.integer(total_events[,i])
#}

#___Webpage scraped, now for storing raw data 
#reading_of_polisen85716
#old_data <- read.csv("reading_of_polisen85716.csv",header =TRUE,stringsAsFactors = TRUE)
old_data <- read.csv(filename_history,header =TRUE,stringsAsFactors = TRUE)
#correct_old_data <- subset(old_data, EventYear != 2)
#nrow(old_data)-nrow(correct_old_data)



old_data$EventYear <- as.factor(old_data$EventYear)
old_data$EventMonth <- as.factor(old_data$EventMonth)
old_data$EventDay <- as.factor(old_data$EventDay)
old_data$EventHour   <- as.factor(old_data$EventHour)
old_data$EventMinute <- as.factor(old_data$EventMinute)


#old_data$X <- NULL
temp_table <- rbind(total_events,old_data)
master_table <- distinct(temp_table, ID, .keep_all = TRUE)
random_filename <- as.character(round(runif(1, 10000, 99999)))
filename_store  <- as.character(paste("reading_of_polisen", random_filename,".csv", sep =""))
write.csv(master_table, file = filename_store, row.names = FALSE)
write(filename_store,file= "./filename.txt")

