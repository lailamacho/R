### Cvičení_08
library(dplyr)
library(ggplot2)
library(lubridate)

df<- read.csv("data.csv")
df[-1] # vynechání prvního sloupce z dataframu

# uprava formátu datumů
df$Start <- str_extract_all(df$Start,"\\d{4}.*\\d{2}.*\\d{2}",simplify = TRUE) %>%
  str_replace_all("\\D+","")
df$End <- str_extract_all(df$End,"\\d{4}.*\\d{2}.*\\d{2}",simplify = TRUE)%>%
  str_replace_all("\\D+","")

df$Start<-ymd(df$Start)
df$End<-ymd(df$End)
df

# výpočet trvání
df["Duration"] <- df$End-df$Start


# překrývání s fází Write_Report
WR_start <- df$Start[df$Stage == "Write Report"]
WR_end   <- df$End[df$Stage == "Write Report"]
df$is_overlap_with_WR <- (df$Start <= WR_end) & (df$End >= WR_start)
df
#overlapping <- df %>% filter(Stage != "Write Report" & Start <= WR_end & End >= WE_start)


# Ganttův diagram -> x=čas, y=názvy fází, barva=ne/dokončené
