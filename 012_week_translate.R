week_translate <- function(dayofweek){
  if     (dayofweek == "m�ndag")  {dayofweek_en <- "Monday"} 
  else if(dayofweek == "tisdag")  {dayofweek_en <- "Tuesday"}
  else if(dayofweek == "onsdag")  {dayofweek_en <- "Wednesday"}
  else if(dayofweek == "torsdag") {dayofweek_en <- "Thursday"}
  else if(dayofweek == "fredag")  {dayofweek_en <- "Friday"}
  else if(dayofweek == "l�rdag")  {dayofweek_en <- "Saturday"}
  else if(dayofweek == "s�ndag")  {dayofweek_en <- "Sunday"}
  else {dayofweek_en <- "None..."}
  return(dayofweek_en) 
}