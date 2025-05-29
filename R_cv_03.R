### Cvičeni_03
library(rvest)
library(dplyr)

#### Práce s tabulkou Vedouci
tables <- html_table(read_html(url("https://ki.ujep.cz/cs/historie/")), header=TRUE)
tab_vedouci <- tables[[2]]
tab_vedouci$Do[tab_vedouci$Do == "dosud"] <- 2024 # filtrace radku podminkou, ktera vraci vektor true/false
tab_vedouci$Do <- as.numeric(tab_vedouci$Do)
tab_vedouci["Celkem_let"] <- tab_vedouci$Do - tab_vedouci$Od
tab_vedouci %>% arrange(desc(Celkem_let)) 

#### Práce s daty StudentsPerformace.csv
# přidání sloupce avg_score
df <- read.csv("StudentsPerformance.csv")
df["avg_score"] <- rowMeans(data.frame(df$math.score, df$reading.score, df$writing.score))
#df %>% mutate("avg_score"=(reading.score+math.score+writing.score)/3.0) -> df
print(head(df))

# filtrace na základě hodnot sloupce
#select(contains("XXX")) hledá pouze v názvech sloupců!!!
df %>% filter(grepl(".*high school.*", parental.level.of.education)) -> df2
head(df2)

# výpočet průměrné hodnoty avg_score pro každou kompinaci kategorií 'gender' a 'race.ethnicity'
df3 <- aggregate(avg_score ~ gender + race.ethnicity, data=df2, mean)
#df2 %>% group_by(gender, race.ethnicity) %>% summarise(avg=mean(avg_score)) -> df3
df3
# úprava formátu tabulky (gender -> sloupce)
library(tidyr)
df3 %>% pivot_wider(names_from=gender,values_from=avg_score) -> df4
df4
# nový sloupec - procentuální rozdíl mezi sloupcemi male a female
df4 %>% mutate("perc"=(100*(female-male)/female)) -> df4
df4