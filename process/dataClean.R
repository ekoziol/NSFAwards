library(ggmap)
library(reshape2)
library(zipcode)

nsf <- read.csv("compiledNoText.csv", as.is=TRUE)
nsf <- nsf[nsf$Agency == "NSF" & nsf$Awardee.Country == "US",]

dropcols <- c("Unnamed.44","PD.PI.Email","PD.PI.Phone", "Federal.Award.ID.Number", "X", "Transaction.Type", "Publications.Produced.as.a.Result.of.this.Research", "Publications.Produced.as.Conference.Proceedings","Abstract.at.Time.of.Award")
includecols <- c("Award.Start.Date", "Funds.Obligated.to.Date", "Awardee.ZIP")
  
# nsf <- nsf[, !(names(nsf) %in% dropcols)]
# write.csv(nsf, "compiledNoText.csv")

nsf <- nsf[, (names(nsf) %in% includecols)]
nsf$Award.Start.Date <- as.Date(nsf$Award.Start.Date, "=\"%m/%d/%Y\"")
nsf$Funds.Obligated.to.Date <- gsub("(,)","",  nsf$Funds.Obligated.to.Date)
nsf$Funds.Obligated.to.Date <- gsub("(\\$)","",  nsf$Funds.Obligated.to.Date)
nsf$Funds.Obligated.to.Date <- gsub("(\")","",  nsf$Funds.Obligated.to.Date)
nsf$Funds.Obligated.to.Date <- gsub("(\\=)","",  nsf$Funds.Obligated.to.Date)
nsf$Funds.Obligated.to.Date <- as.numeric(nsf$Funds.Obligated.to.Date)

nsf$Award.Start.Date <- as.character(substring(nsf$Award.Start.Date,1,4))
names(nsf) <- c("year", "zip", "funds")

nsf$zip <- gsub("(\")","",  nsf$zip)
nsf$zip <- gsub("(\\=)","",  nsf$zip)
nsf$zip <- substring(nsf$zip,1,5)

nsfmelt <- melt(nsf, id.vars = c("year", "zip") ,measure.vars = "funds")
nsfd <- dcast(nsfmelt, year + zip ~ variable, sum)

data(zipcode)
findLat <- function(x){
  return(zipcode[zipcode$zip == x, "latitude"])
}

findLong <- function(x){
  return(zipcode[zipcode$zip == x, "longitude"])
}

nsfd$lat <- t(t(sapply(nsfd$zip, findLat)))
nsfd$long <- t(t(sapply(nsfd$zip, findLong)))
nsfd$lat <- as.numeric(nsfd$lat)
nsfd$long <- as.numeric(nsfd$long)

nsfd <- nsfd[!is.na(nsfd$lat),]

write.csv(nsfd, file = "processedData.csv")