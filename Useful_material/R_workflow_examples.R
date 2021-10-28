# Simplifying "looping" in R
rm(list=ls())

# Letters of love
a <- c("Romeo", "Simba", "Alladin")
b <- c("Julia", "Nala", "Esmarla")

c <- c("Ridge", "Eric", "Rick")
d <- c("Brooke", "Taylor", "Stephanie" )


(monogamy_s <- paste(a,b))
(polyamory_s <- sapply(c, function(x) paste(x,d)))

#numbers of love
(g <- matrix(c(1,2,3),3,1))
(h <- matrix(c(4,5,6),1,3))

(monogamy_n <- h*t(g))
(polyamory_n <- sapply(g,function(x) x*h))
#(polyamory_n2 <- g%*%h)


monogamy_s
polyamory_s
monogamy_n
polyamory_n

###########################

# same with for-loops

#monogamy
for(i in 1:3) {
  print(c(a[i],b[i]))
}

#polyamory
for(i in 1:3) {
  for(j in 1:3) {
  print(c(a[i],b[j]))
  } 
}

