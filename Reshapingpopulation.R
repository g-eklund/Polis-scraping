setwd("C:/Users/gustav.eklund/Data_Science/R/Testlab/Environments/Polisen_3")
kommundata <- read.csv("BE0101N12.txt", sep =",", header = T)
kommundata$ålder <- NULL
colnames(kommundata) <- c("region", "civilstand", "kon", "mangd")
#reshape(kommundata, idvar = "kon", direction = "long", varying = "region")
library(reshape)
reshapeX <- cast(kommundata, region~civilstand+kon, value = guess_value(kommundata), sum)
kommunID <- as.data.frame(substring(reshapeX$region, 1,4))
#kommunnamn <-as.data.frame(substring(reshapeX$region, 6,100))


hepp <- cbind(kommunID, 
              reshapeX$gifta_kvinnor,
              reshapeX$gifta_män,
              reshapeX$ogifta_kvinnor,
              reshapeX$ogifta_män,
              reshapeX$skilda_kvinnor,
              reshapeX$skilda_män,
              reshapeX$`änkor/änklingar_kvinnor`,
              reshapeX$`änkor/änklingar_män`)


colnames(hepp) <- c("KommunKod", 
                    "AntalGiftaKvinnor",
                    "AntalGiftaMän",
                    "AntalOgiftaKvinnor",
                    "AntalOgiftaMän",
                    "AntalSkildaKvinnor",
                    "AntalSkildaMän",
                    "Änkor",
                    "Änklingar")


lankod <- as.data.frame(substring(kommundata$region, 1,2))
kommundata2 <- cbind(lannamn,kommundata)
kommundata2$region <- NULL
colnames(kommundata2) <- c("region", "civilstand", "kon", "mangd")
reshapeX2 <- cast(kommundata2, region~civilstand+kon, value = guess_value(kommundata2), sum)

colnames(reshapeX2) <- c("KommunKod", 
                    "AntalGiftaKvinnor",
                    "AntalGiftaMän",
                    "AntalOgiftaKvinnor",
                    "AntalOgiftaMän",
                    "AntalSkildaKvinnor",
                    "AntalSkildaMän",
                    "Änkor",
                    "Änklingar")


hepp2 <- rbind(hepp,reshapeX2)

write.csv(hepp2,"hepp2.csv", row.names = F)




#kuken <-unlist(strsplit(as.character(reshapeX$region), " "))
