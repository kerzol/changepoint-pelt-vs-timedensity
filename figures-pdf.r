## Generate pdfs for paper
###############################

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


