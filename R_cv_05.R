### Cvičení_05
library(dplyr)
library(ggplot2)
library(lubridate)
library(DT)
df <- read.csv("shootings.csv")
df$date <- ymd(df$date)
df$year <- year(df$date)

# 5 států, kde dochází nejčastěji ke sřelbě při zásaích
df %>% group_by(state) %>% summarise(total=n()) -> pocet
pocet %>% slice_max(order_by=total, n=5)-> pocetMax
DT::datatable(pocetMax)


# pro každý stát sloupcový graf (počet zastřelených v letech)
#filtered_df <- df[df$state %in% pocetMax$state, ]
df %>% filter(state %in% pocetMax$state) %>% group_by(state, year)%>%count() %>%
  ggplot(aes(x=year,y=n)) + geom_col() + facet_wrap(~state)


# 10 nejméně zastoupených hodnot zbraní
df %>% group_by(armed) %>% summarise(pocet=n()) -> zbrane.pocet
zbrane.pocet %>% slice_min(order_by=pocet, n=10)
#df %>% group_by(armed)%>% summarise(pocet=n()) %>%arrange(pocet) %>% head(10)


# koláčový graf - četnost útočníku s těmito zbraněmi

zbrane <- c("toy weapon", "ax", "crossbow", "machete", "gun")
df %>% filter(armed %in% zbrane) %>% group_by(armed) %>%
  summarise(n_utocniku=n()) -> pocet.utocnikus

ggplot(pocet.utocniku, aes(x="", y=n_utocniku, fill=armed)) + geom_col() +
  labs(fill="armed") + xlab("") + ylab("") + coord_polar("y")
