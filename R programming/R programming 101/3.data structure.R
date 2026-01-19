## sata structure

##1 vector
#store only one type of data 
1:11
seq (from =1,to=100,by=2)
help("seq")
#function c
friends <- c("David","Marry","Anna","John","William")
ages <- c(30,31,25,29,32)
is_male<- c(T,F,F,T,T)

##2 matrix
X<-1:25
length(X)
dim(X) <- c(5,5)

matrix1(1:25,ncol=5)
matrix2(1:6,ncol=3,nrow=2,byrow=T)
#element wise computation
matrix1+100
matrix2*4

##3 list
My_name <- "Bright"
ml <- matrix(1:25,ncol=5)
R_is_coll=T
my_list <- list(item1=My_name,item2=ml,
            item3=R_is_coll)
my_list$item2
my_list$item3

##4 data frame
friends <- c("wan","Ink","Aan","Bee","Top")
ages <- c(26,27,31,31,28)
locations <- c("New york","London","Bangkok","Tokyo","Manchester")
movie_lover <- c(T,T,F,T,T)

df <- data.frame(friends,ages,
                 locations,movie_lover)
view(df)

#create df from list
my_list <- list(friends=friends,
                ages=ages,
                locations=locations,
                movie=movie_lover )

list_df <- data.frame(my_list)
list_df[,c(2,4,3)]
list_df[c(2,4,3)]