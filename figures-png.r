## Generate pngs for github
###############################

h=400
w=800

png("fig/timedensity-big.png",
    height=h,width=w)

par(mfrow=c(1,1))
par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.timedensity (uk, bw=500000)
title (ylab='Densité temporelle', cex.lab=0.7, line=1) 

dev.off()


png("fig/timedensity-small.png",
    height=h,width=w)

par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.timedensity (uk, bw=120000)
title (ylab='Densité temporelle', cex.lab=0.7, line=1) 

dev.off()


png("fig/changepoint-pelt-normal-6hours.png",
    height=h,width=w)

par(mfrow=c(1,1))
par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 6 * hour)
title (ylab='fréquence des tweets', cex.lab=0.7, line=1)

dev.off()


png("fig/changepoint-pelt-normal-48hours.png",
    height=h,width=w)

par(mfrow=c(1,1))
par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 48 * hour)
title (ylab='fréquence des tweets', cex.lab=0.7, line=1)

dev.off()




png("fig/changepoint-pelt-gamma-6hours.png",
    height=h,width=w)

par(mfrow=c(1,1))
par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 6 * hour, test.stat = 'Gamma')
title (ylab='fréquence des tweets', cex.lab=0.7, line=1)

dev.off()


png("fig/changepoint-pelt-gamma-48hours.png",
    height=h,width=w)

par(mfrow=c(1,1))
par(mar=c(3,3,0,0))
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 48 * hour, test.stat = 'Gamma')
title (ylab='fréquence des tweets', cex.lab=0.7, line=1)

dev.off()


