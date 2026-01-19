##data types

# numeric
age<-31
print(age)
class(age)

# character
my_name <-'Wawiss'
my_university <-"Mahidol"
my_status ='single'
print(my_name)
print(my_university)
class(my_name);class(my_university)

#logical
result <- 1+1==2
print(result)
class(result)

#factor
#concat value into vector
animals<- c("Dog","Cat","Tiger","Raven")
animals<- factor(animals)
class(animals)

#date/time 
time_now<-Sys.time()
class(time_now)

##convert data type
x<-100
x
#change to numeric
num_x<- as.numeric(char_x)

#change to character
char_x<- as.character(x)

#change to logical
as.logical(0)
as.logical(1)