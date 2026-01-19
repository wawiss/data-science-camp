  ##function

x<- c(10,25,50,100)
sum(x)
mean(x)

  ##create function
greeting <- function()
{print("Hello world")}

greeting_name <- function(name){
  print(paste("hello!",name))
}

func<- function()
{greeting()
  greeting_name("B")}

#default argument
#name & age is parameter
#toy &25 is default argument 
greeting_name2 <- function(name="Toy",age=25){
  print(paste("hello!",name))
  print(paste("Age: ",age))
  
  
  ##add_two_nums function
  add_two_nums <- function(num1,num2)
  {result <- num1+num2
  return(result) }
  
  ##cube function
  cube <- function (base,power=3)
  {return(base**power)}
  
  ##count ball function
  balls <-c("black","blue","purple","pink","blue","black")
  
  count_balls <- function(balls,colors)
  {
    sum(balls==colors)
  }
  