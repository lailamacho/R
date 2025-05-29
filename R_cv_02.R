### Cvičení_02

#### Fibinacciho posl. (vlastní fce)

fibonacci <- function(n){
  if(n==1) return(0)
  x <- numeric(n)
  x[1:2] <- c(0, 1)
  if(n>2){
    for(i in 3:n){
      x[i] <- x[i-1] + x[i-2]
    }
  }
  return(x)
}

print(fibonacci(10))

#### Kořeny kvadratické rovnice
kvadr.koreny <- function(a, b, c){
  D <- b^2-4*a*c
  if(D < 0) D <- as.complex(D)
  
  x1 <- (-b + sqrt(D))/2*a
  x2 <- (-b - sqrt(D))/2*a
  return(c(x1, x2))
}

print(kvadr.koreny(1, 2, -1))

#### Práce s tabulkami - data iris
str(iris) # struktura - datove typy sloupcu, pocet radku atd.
sapply(iris[1:4], mean)
sapply(iris[1:4], sd)

summary(iris$Species)

#### Tabulky z HTML
library(rvest)
tables <- html_table(read_html("https://ki.ujep.cz/cs/historie/"), header=TRUE)
tab_vedouci <- tables[[2]]
tables[[3]] <- tab_vedouci[tab_vedouci$`Působí na UJEP?` == "ANO",]

# uložení do xlsx
library(writexl)
write_xlsx(tables, "historieKI.xlsx")