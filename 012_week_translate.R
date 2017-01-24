week_translate <- function(dayofweek){
  if     (dayofweek == "måndag")  {dayofweek_en <- "Monday"} 
  else if(dayofweek == "tisdag")  {dayofweek_en <- "Tuesday"}
  else if(dayofweek == "onsdag")  {dayofweek_en <- "Wednesday"}
  else if(dayofweek == "torsdag") {dayofweek_en <- "Thursday"}
  else if(dayofweek == "fredag")  {dayofweek_en <- "Friday"}
  else if(dayofweek == "lördag")  {dayofweek_en <- "Saturday"}
  else if(dayofweek == "söndag")  {dayofweek_en <- "Sunday"}
  else {dayofweek_en <- "None..."}
  return(dayofweek_en) 
}