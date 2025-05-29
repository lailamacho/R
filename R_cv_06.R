### Cvičení_06
library(dplyr)
library(ggplot2)

df <- read.csv("StudentsPerformance.csv")

# průměrná hodnota z náhodného vzorku
df$math.score %>% mean(sample(n=10)) -> math.mean
math.mean
