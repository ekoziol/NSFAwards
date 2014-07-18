files <- list.files("raw")

dfs <- c()
for(x in files){
  df <- read.csv(x)
  dfs <- c(dfs,df)
}

data <- merge(dfs)
