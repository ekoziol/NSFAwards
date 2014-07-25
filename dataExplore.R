library(ggmap)
library(manipulate)
nsfd <- read.csv("process/processedData.csv")
nsfd$fundsMil <- nsfd$funds/1000000
map <- get_map(location = 'United States', zoom = 4)
gmap <- ggmap(map)
points <- gmap + geom_point(data = nsfd, aes(x=long, y=lat, group=year, size=funds), na.rm=TRUE)
manipulate(gmap + geom_point(data = nsfd[nsfd$year == x,], aes(x=long, y=lat, color=fundsMil, size=fundsMil), na.rm=TRUE), 
           x=slider(unique(nsfd$year[1]),rev(unique(nsfd$year))[1]))