### Cvičení_07
library(dplyr)
library(ggplot2)
library(lubridate)
library(DT)

df <- read.csv("catalog.csv")
df$date <- mdy(df$date)
df$year <- year(df$date)
df$month <- month(df$date)

# počet sesuvů v jednotlivých letech
df %>% group_by(year) %>% summarise(pocet=n()) -> df2
DT::datatable(df2)


# kumulativní součet po rocích + vykreslení 
df2["cum_sum"] <- cumsum(df2$pocet)
DT::datatable(df2)


# vykreslení cumsum vzhledem k roku 
ggplot(df2, aes(year, cum_sum)) + geom_line()


# průměrný počet sesuvů v USA v jednotlivých měsících 
# vykreslit do grafu
df %>% filter("United States" %in% country_name) %>% group_by(month) %>%
  summarise(mesicni.prumer=mean(n())/12) -> df3 # děleno 12 měsíců
#df %>% filter(country_name=="United States") %>% group_by(year,month) %>% summarise(total=n()) %>%  group_by(month) %>% summarise(avg=mean(total)) -> months

ggplot(df3, aes(month, mesicni.prumer)) + geom_line()


# průměrný počet ročních sesuvů pro každý stát
df %>% group_by(year, country_name) %>% summarise(celkem=n()) %>%
  group_by(country_name) %>% summarise(prum.rok=mean(celkem)) %>%
  arrange(desc(prum.rok)) -> staty.rok

DT::datatable(staty.rok)


# vykreslení do mapy
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(stringr)

world <- ne_countries(scale = "medium", returnclass = "sf")
world %>% ggplot(aes(geometry=geometry)) + geom_sf()


world2 <- left_join(world,staty,by=c("name"="country_name"))
world2 %>% filter(str_detect(continent,".*America")) %>% 
  ggplot(aes(geometry=geometry,fill=avg)) + geom_sf()
