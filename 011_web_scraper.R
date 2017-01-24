#web_scraper
web_scraper <- function(page) {

  require(rvest)
  Sys.setenv(LANG = "en")
  url_part1 <- "https://polisen.se/Aktuellt/Handelser/Handelser-i-hela-landet/?p="
  url_part2 <- "&tbSearch=&ddl=0&tbFrom=&tbTo="
  url_path  <-  paste(url_part1, page,url_part2, sep = "")

  unstructured_data   <- read_html(url_path)
  structured_web_data <- html_nodes(unstructured_data, xpath = "//h3/a" )
  text_extract        <- html_text(structured_web_data)
  event_details       <- NULL
  
  for (i in 1:length(text_extract)){
    extract         <- unlist(strsplit(text_extract[i], ","))   # Extract categories (date, area, category)
    event_area      <- tail(extract, n = 1)                     # Area as the last element in extract 
    event_date      <- extract[1]                               # Event date raw format
    date_breakdown  <- unlist(strsplit(event_date, " "))        # Date brakdown to date ad time separated
    date_breakdown2 <- unlist(strsplit(date_breakdown[1], "-")) # date breakdown to year, month, date
    event_year      <- date_breakdown2[1]                       # Year
    event_month     <- date_breakdown2[2]                       # Month
    event_day       <- date_breakdown2[3]                       # Day
    event_weekday   <- weekdays.Date(as.Date(date_breakdown[1]))
    event_weekday_en<- week_translate(event_weekday)
    
    hour_breakdown  <- unlist(strsplit(date_breakdown[2], ":"))
    event_hour      <- hour_breakdown[1]
    event_minute    <- hour_breakdown[2]
    
    #event category dependent on detail level in extract
    if (length(extract) == 4) {
      event_category <- paste(extract[2], extract[3], sep= ",")
    }
    else if (length(extract) == 5){
      event_category <- paste(extract[2], extract[3], extract[4], sep= ",")
    }
    else{     
      event_category <- extract[2]
    }
    event_category   <- substr(event_category, 2,1000)
    event_area       <- substr(event_area, 2, 100)
    ID               <- paste(substr(event_category,2,4),event_year, event_month, event_day, event_hour, event_minute, sep = "")
    event_details    <- rbind(event_details, c(ID, event_year, event_month, event_day, event_weekday_en, event_hour, event_minute, event_area, event_category))
  }
  structured_event_details        <- event_details
  return(structured_event_details)
}

