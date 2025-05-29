### Cvičení_01

x <- 2
print(round(sqrt(cos(x + 3/2*pi)), 3))
print(round(log(2*x^2+10, base=4), 3))

x <- 4
print(round(sqrt(as.complex(cos(x + 3/2*pi))), 3))
print(round(log(2*x^2+10, base=4), 3))


#### Textové řetězce

text <- "copak zlaTOvláska ale JMELí!"
text2 <- tolower(text)
substr(text2,1,1) <- toupper(substr(text2,1,1))
substr(text2,7,7) <- toupper(substr(text2,7,7))
text2

#### Vektory a matice

pole1 <- c(1, 2, 3)
pole2 <- c(3, 4, 5)

skalar.soucin <- sum(pole1*pole2)

rozdil <- pole2-pole1
vzd <- sgrt(sum(rozdil^2))

#-
vektor <- 0:10
vektor <- vektor/max(vektor)*2
print(vektor)

#-
rozsah <- -10:10
vyber <- (rozsah < 0) & !(rozsah%%2 == 0) | (rozsah >= 0) & (rozsah%%2 == 0)
rozsah[vyber]

#-
text <- "Well, there's egg and bacon; egg sausage and bacon; egg and spam;
egg bacon and spam; egg bacon sausage and spam; spam bacon sausage and spam;
spam egg spam spam bacon and spam;
spam sausage spam spam bacon spam tomato and spam;"

text2 <- as.factor(scan(text=text, what=" "))
table(text2)

#- 
A <- matrix(1:16, ncol= 4, nrow=4)
A[1,] <- c(-1, 1, -1, 1)
A[2,] <- c(-2, 1, 1, -3)
A[3,] <- c(1, 2, 3, 1)
A[4,] <- c(2, 3, 4, -1)
b <- c(0, 0, 0, 0)
x <- solve(A, b)
x

#-
M <- matrix(c(4, 4, -2, 2, 6, 2, 2, 8, 4), ncol=3, nrow=3)

N <- matrix(rep(0, 9), ncol=3, nrow=3) # N[,]=0
N[1,1] <- sum(M[1,]*M[,1])
N[2,2] <- sum(M[2,]*M[,2])
N[3,3] <- sum(M[3,]*M[,3])
N

C <- M%*%N
C

C[C<0] <- abs(C[C<0])
C