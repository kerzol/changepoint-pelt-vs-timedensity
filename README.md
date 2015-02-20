    ##################################################################################
    ##    __ .                         ,      .__ .___.   .___.                      #
    ##   /  `|_  _.._  _  _ ._  _ *._ -+- ___ [__)[__ |     |    .  , __             #
    ##   \__.[ )(_][ )(_](/,[_)(_)|[ ) |      |   [___|___  |     \/ _)              #
    ##                ._|   |                                                        #
    ##    ,                 .           ,                                            # 
    ##   -+-*._ _  _  ___  _| _ ._  __*-+-  .                                        #
    ##    | |[ | )(/,     (_](/,[ )_) | | \_|                                        #
    ##                                    ._|                                        #
    ##                                                                               #
    ##   by Sergey Kirgizov                                                          #
    ##                                                                               #
    ##################################################################################


# Before use


```R
install.packages('changepoint')
install.packages('strucchange')
install.packages('pastecs')
```


# Examples


[Les   timestamps   des  tweets](./data/tweets_timestamp_count)   sont
représenté par la ligne  grisée en bas de la figure.  Plus  il y a des
tweets, plus  la couleur  est foncée.   Les lignes  noires pointillées
sont  [les événements  réels](./data/European Parliamentary  Elections
2014 key  dates uk.txt).  Les lignes  rouges pointillées correspondent
aux  événements  détectés par  les  algorithmes.   Les courbes  noires
montrent  la fréquence  des  tweets (Changepoint-PELT)  ou la  densité
temporelle.   Dans  le  cas  de  Changepoint-PELT  les  lignes  rouges
horizontales indiquent les intervalles stables.


## Overview

### Time-density

Triangular and normal kernels give very **simmilar results**.

                  | Small bandwith                                                      | Large bandwith
----------------- | ------------------------------------------------------------------- | -----------------------------------------------------------------------------
Normal kernel     | <img src="fig/timedensity-small.png" width="100%">                   | <img src="fig/timedensity-big.png" width="100%">
Triangular kernel | <img src="fig/timedensity-small-triangular-kernel.png" width="100%"> | <img src="fig/timedensity-big-triangular-kernel.png" width="100%">



### Changepoint-PELT

Normal and Gamma distributions give very **different results**.


                     | 6 hours                                                             | 48 hours
-------------------- | ------------------------------------------------------------------- | -----------------------------------------------------------------------------
Normal distribution  | <img src="fig/changepoint-pelt-normal-6hours.png" width="100%">      | <img src="fig/changepoint-pelt-normal-48hours.png" width="100%">
Gamma  distribution  | <img src="fig/changepoint-pelt-gamma-6hours.png" width="100%">       | <img src="fig/changepoint-pelt-gamma-48hours.png" width="100%">


## Time-density


### Normal kernel. Large bandwith

```R
plot.tweets (notevery(uk,2300))
add.real.events ()
add.timedensity (uk, bw=500000)
```

![Time-density: large bandwith](fig/timedensity-big.png)

### Normal kernel. Small bandwith

```R
plot.tweets (notevery(uk,2300))
add.real.events ()
add.timedensity (uk, bw=120000)
```
![Time-density: large bandwith](fig/timedensity-small.png)


### Triangular kernel. Large bandwith

```R
plot.tweets (notevery(uk,2300))
add.real.events ()
add.timedensity (uk, bw=500000, kernel='triangular')
```

![Time-density: large bandwith](fig/timedensity-big-triangular-kernel.png)

### Triangular kernel. Small bandwith

```R
plot.tweets (notevery(uk,2300))
add.real.events ()
add.timedensity (uk, bw=120000, kernel='triangular')
```
![Time-density: large bandwith](fig/timedensity-small-triangular-kernel.png)



## Changepoint-PELT

### Normal distribution. Time-window's size is 6 hours

```R
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 6 * hour)
```

![Time-density: large bandwith](fig/changepoint-pelt-normal-6hours.png)

### Normal distribution. Time-window's size is 48 hours

```R
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 48 * hour)
```

![Time-density: large bandwith](fig/changepoint-pelt-normal-48hours.png)


### Gamma distribution. Time-window's size is 6 hours

```R
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 6 * hour, test.stat = "Gamma")
```

![Time-density: large bandwith](fig/changepoint-pelt-gamma-6hours.png)

### Gamma distribution. Time-window's size is 48 hours

```R
plot.tweets (notevery(uk,2300))
add.real.events ()
add.changepoints (uk, window = 48 * hour, test.stat = "Gamma")
```

![Time-density: large bandwith](fig/changepoint-pelt-gamma-48hours.png)