rm(list=ls())
library(tidyverse)
setwd('C:/Users/mmak/OneDrive/Tilasto/causality/excercise_wednesday/')

# here I included some libraries we used and are commonly very useful. You can edit as you prefer

libraries <- c("ggplot2", "tidyverse", "data.table", "cobalt", "WeightIt", "haven","lmtest","sandwich")

# Install packages if not yet installed
installed_libraries <- libraries %in% rownames(installed.packages())

if (any(installed_libraries == FALSE)) {
  install.packages(libraries[!installed_libraries])
}

lapply(libraries, require, character = TRUE)


####
dt <- read_csv("sim_dat_w3.csv",show_col_types = FALSE)
head(dt)



#######

dt %>% group_by(treat1) %>% 
  summarise(age = mean(age),
            sex = mean(sex),
            c1 = mean(c1))

dt %>% group_by(treat2) %>% 
  summarise(age = mean(age),
            sex = mean(sex),
            c2 = mean(c2))

dt %>% group_by(treat3) %>% 
  summarise(age = mean(age),
            sex = mean(sex))


#####3


ps1 <- glm(treat1 ~ c0 + sex + age,family=binomial,dt)$fitted.values

ps2 <- glm(treat2 ~ c1 + sex + age,family=binomial,dt)$fitted.values

ps3 <- glm(treat3 ~ c2 + sex + age,family=binomial,dt)$fitted.values

dt <- dt %>% mutate(w1 = treat1/ps1 + (1-treat1)/(1-ps1),
                    w2 = treat2/ps2 + (1-treat3)/(1-ps2),
                    w3 = treat3/ps3 + (1-treat3)/(1-ps3),
                    w = w1 *w2* w3)

dt



head(dt$w)

summary(dt$w)


msm <- weightitMSM(list(treat1 ~ c0 + sex + age,
                        treat2 ~ c1 + sex + age,
                        treat3 ~ c2 + sex + age),
                        data = dt,
                        method = "ps",stabilize = F)

                   head(msm$weights)
                   summary(msm$weights)
                   
                   bal.tab(msm, thresholds = .05)
                   
                   bal.tab(list(dt[c("c0", "sex", "age")],
                                dt[c("c0", "sex", "age", "c1", "treat1")],
                                dt[c("c0", "sex", "age", "c1", "treat1", "c2", "treat2")]),
                           treat.list = dt[c("treat1", "treat2", "treat3")],
                           which.time = .all, threshold=.05)
                   
                   bal.plot(msm, var.name = "age", which = "both")
                   
                   bal.plot(msm, var.name = "c2", which = "both")
                   
#######
                   
                   
num1 <- glm(treat1~1,family=binomial,dt)$fitted.values
num2 <- glm(treat2~treat1,family=binomial,dt)$fitted.values
num3 <- glm(treat3~treat2*treat1,family=binomial,dt)$fitted.values
