library(ggmap)
library(reshape2)

nsf <- read.csv("combinedData.csv", as.is=TRUE)
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

nsf$Award.Start.Date <- as.numeric(substring(nsf$Award.Start.Date,1,4))
names(nsf) <- c("year", "zip", "funds")

nsf$zip <- gsub("(\")","",  nsf$zip)
nsf$zip <- gsub("(\\=)","",  nsf$zip)

nsfmelt <- melt(nsf, id.vars = c("year", "zip") ,measure.vars = "funds")
nsfd <- dcast(nsfmelt, year + zip ~ variable, sum)
nsfd$lat <- sapply(nsfd$zip, geocode()$lat)