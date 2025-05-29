### Cvičení_04
library(dplyr)
library(ggplot2)
df <- read.csv("StudentsPerformance.csv")


# bodový graf
plot(df$writing.score, df$reading.score, main="Writing vs reaging score",
     xlab="writing score", ylab="reading score")

ggplot(df, aes(writing.score, reading.score)) +geom_point() + labs(title="Wrting vs reading score") +
  xlab("writing score") + ylab("reading score")


# histogram
df["avg_score"] <- rowMeans(data.frame(df$math.score, df$reading.score, df$writing.score))
hist(df$avg_score, main="Rozdělení počtu bodů", xlab="počet bodů", ylab="četnost")

ggplot(df, aes(avg_score)) + geom_histogram(bins=10, fill='grey', col='black') +
  labs(title="Rozdělení počtu bodů") + xlab("počet bodů") + ylab("četnost")


# boxplot
boxplot(df$math.score~df$race.ethnicity, main="Výsledky testů z matematiky",
        xlab="etnikum", ylab="počet bodů")

ggplot(df, aes(race.ethnicity, math.score)) +geom_boxplot() +
  labs(title="Výsledky testů z matematiky") + xlab("etnikum") + ylab("počet bodů")


# stejné boxploty, ale zvlášť pro kategorie z 'gender'
ggplot(df, aes(race.ethnicity, math.score)) +geom_boxplot() +
  labs(title="Výsledky testů z matematiky") + xlab("etnikum") + ylab("počet bodů") +
  facet_wrap(~gender)


# Výpočet kolik záznamů připadá na jednotlivé kategorie z 'race.ethnicity', 
# vykreslit jako sloupcový graf
df %>% group_by(race.ethnicity) %>% summarise(pocet=n()) -> df2
barplot(names=df2$race.ethnicity, height=df2$pocet)

ggplot(df2, aes(race.ethnicity, pocet)) + geom_col(fill='grey', col='black') + 
  labs(title="Kontrola vyváženosti statistického vzorku") + xlab("etnikum") + 
  ylab("počet testovaných")

# subgrafy pro gender
df %>% group_by(race.ethnicity, gender) %>% summarise(pocet=n()) -> df3
ggplot(df3, aes(race.ethnicity, pocet)) + geom_col(fill='grey', col='black') + 
  labs(title="Kontrola vyváženosti statistického vzorku") + xlab("etnikum") + 
  ylab("počet testovaných") + facet_wrap(~gender)

# subgrafy jako koláčové grafy
ggplot(df3, aes(x="", y=pocet, fill=race.ethnicity)) + geom_col(col='black') + 
  labs(title="Kontrola vyváženosti statistického vzorku", fill='ethnicum') + 
  xlab("") + ylab("") + coord_polar("y") + facet_wrap(~gender)
