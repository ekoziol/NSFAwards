nsf <- read.csv("combinedData.csv")
nsf <- nsf[nsf$Agency == "NSF",]

dropcols <- c("Unnamed.44","PD.PI.Email","PD.PI.Phone", "Federal.Award.ID.Number", "X", "Transaction.Type", "Publications.Produced.as.a.Result.of.this.Research", "Publications.Produced.as.Conference.Proceedings","Abstract.at.Time.of.Award")

nsf <- nsf[, !(names(nsf) %in% dropcols)]
write.csv(nsf, "compiledNoText.csv")