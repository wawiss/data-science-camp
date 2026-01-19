##subset data

friends <- c("wan","Ink","Aan","Bee","Top")
ages <- c(26,27,31,31,28)
locations <- c("New york","London","Bangkok","Tokyo","Manchester")
movie_lover <- c(T,T,F,T,T)


df <- data.frame(friends,ages,
                 locations,movie_lover)


    ##subset data vector
#subset by position
friends[1]
friends[1:3]
friends[c(1,3,5)]

#subset by condition
ages[ages>30]
ages[ages<=28]

#subset by name
names(ages) <- friends
ages["wan"]
ages[c("wan","Ink","Top")]

  ##subset by data frame
View(df)
#subset by position
df[1,3]
df[1:2,2:4]
df[,"friends"]
df[,c("friends","locations")]

#subset by condition 
#$ used to select col
df[df$movie_lover==TRUE,]
df[df$ages<30,]

#subset by name
df[df$friends=="Top",]
