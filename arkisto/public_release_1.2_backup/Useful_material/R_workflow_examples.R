# Simplifying "looping" in R


rm(list=ls())
a <- c("Romeo", "Simba", "Alladin")
b <- c("Julia", "Nala", "Esmarla")

c <- c("Ridge", "Eric", "Rick")
d <- c("Brooke", "Taylor", "Stephanie" )


(monogamy_s <- paste(a,b))
(polyamory_s <- lapply(c,function(x) paste(x,d)))

(g <- matrix(c(1,2,3),3,1))
(h <- matrix(c(4,5,6),1,3))

(monogamy_n <- h*t(g))
(polyamory_n <- g%*%h)


monogamy_s
polyamory_s
monogamy_n
polyamory_n