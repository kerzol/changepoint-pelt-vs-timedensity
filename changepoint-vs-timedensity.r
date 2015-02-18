######
##    __ .                         ,      .__ .___.   .___.         
##   /  `|_  _.._  _  _ ._  _ *._ -+- ___ [__)[__ |     |    .  , __
##   \__.[ )(_][ )(_](/,[_)(_)|[ ) |      |   [___|___  |     \/ _) 
##                ._|   |                                           
##    ,                 .           ,    
##   -+-*._ _  _  ___  _| _ ._  __*-+-  .
##    | |[ | )(/,     (_](/,[ )_) | | \_|
##                                  ._|
##
##   by Sergey Kirgizov
#####


todate.PST <- function (x) as.POSIXct(x, origin="1970-01-01", tz="PST")
notevery <- function (data, howmany = 4000) data[seq(1,nrow(data),floor(nrow(data)/howmany)),]

## load tweets
#######################################

read.table('data/tweets_timestamp_count') -> uk
colnames(uk) <- c('timestamp0','count')
uk$timestamp <- todate.PST(uk$timestamp0)

## load real events
#######################################
events <- read.table('data/European Parliamentary Elections 2014 key dates uk.txt',
                     colClasses=c("character","character"),
                     col.names=c("date","description"))
events$date <- as.POSIXct(events$date, tz="PST") 
events$count <- 1:nrow(events) 


## plot functions
#######################################
plot.tweets <- function(data, ...) {
  x <- data$timestamp0
  y <- rep(0,length(x))
  plot (x, y, xaxt="n",xlab="",ylab="", yaxt="n",
        pch = '|', col = rgb(0,0,0,0.07), ylim=c(0,1), ...)
  at <- todate.PST(format(data$timestamp[seq(1, length(data$timestamp), 400)],"%Y-%m-%d 00:00:00"))
  axis.POSIXct(1,
               at=at,
               labels=format(at,"%b-%d"),
               las=1,
               cex.axis=0.5)
}
plot.tweets (notevery(uk,2000))


add.real.events <- function()  {
  for (d in as.integer(events$date)) {
    abline (v=d, col=rgb(0, 0, 0,.5), lty=2,lwd=2)
  }
###  individualws events as points  
##  points(as.integer(events$date),events$count/10^2,col='black',pch=17)
}

plot.tweets (notevery(uk,5000))
add.real.events ()

## time-density
##########################################
add.timedensity <- function (data, bw = "nrd0", ...) {
  x <- data$timestamp0
  y <- data$count

  ## density
  density(x,bw=bw) -> ddd
  lines (todate.PST(ddd$x), ddd$y * 10**6, ...)

  ## difference
  ##  lines (ddd$x[2:length(ddd$x)], diff(ddd$y * 10**6), col='red')

  ## turnpoints
  require(pastecs)
  tp<-turnpoints(ts(ddd$y))

  for (d in ddd$x[2:length(ddd$x)][tp$tppos]) {
    abline (v=d, col='red', lty=5, lwd=2)
  }
  ## borders
  ##  abline (v=x[1],lwd=2,col='gray')
  ##  abline (v=x[length(x)],lwd=2,col='gray')
}


pdf("fig/timedensity-big.pdf",
    height=2,width=5)

par(mfrow=c(1,1))
par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.timedensity (uk, bw=500000)
title (ylab='Densité temporelle', cex.lab=0.7, line=1) 

dev.off()


pdf("fig/timedensity-small.pdf",
    height=2,width=5)

par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.timedensity (uk, bw=120000)
title (ylab='Densité temporelle', cex.lab=0.7, line=1) 

dev.off()




## breakpoints
############################
library(strucchange)
add.breakpoints <- function(data, h=.1) {
  x <- data$timestamp0 
  y <- data$count
  # caz' there is a bug in the strucchange...
  # Error in sqrt(fr) : (converted from warning) NaNs produced
  xx <- x * 0.1
  yy <- y * 0.1
  abline (v=x[breakpoints(yy~xx,h)$breakpoints])
}
plot.tweets (notevery(uk,2300))
add.real.events ()
add.breakpoints (notevery(uk, 400), h = 0.4)


## changepoints
###########################
library(changepoint)
minute = 60
hour = minute * 24
start = 1398617180
end = 1402748715

add.changepoints <- function(data, window =  6 * hour, test.stat = "Normal") {
  seq(start, end+window, window) -> borders
  hist(data$timestamp0, plot = FALSE, breaks = borders) -> h
  borders[1:length(borders)-1] + window/2. -> x
  ## values will be plotted at interval's centers
  h$counts -> y
  y/max(y) -> y
#  lines (x, y)
  
  cpt.meanvar(h$counts, method="PELT", test.stat = test.stat) -> cpt.results
  cpt.results@cpts -> positions
  abline (v=x[positions], col='red', lty=5, lwd=0.5 )

  par (new=T)
  plot(cpt.results, xlab='', xaxt='n', ylab="", yaxt='n')
}


pdf("fig/changepoint-pelt-normal-6hours.pdf",
    height=2,width=5)

par(mfrow=c(1,1))
par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 6 * hour)
title (ylab='fréquence des tweets', cex.lab=0.7, line=1)

dev.off()


pdf("fig/changepoint-pelt-normal-48hours.pdf",
    height=2,width=5)

par(mfrow=c(1,1))
par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 48 * hour)
title (ylab='fréquence des tweets', cex.lab=0.7, line=1)

dev.off()


