  ## control flow

#1.If
score <-88


if (score>80)
  {
  print("passed")
}else if (score >=50)
{
  print("Ok")
  }else 
  {
  print("Enroll again")}

#2.If-else
ifelse(score>=80,"passed","failed")
ifelse(score>=90,"Passed",
       ifelse(score>=50,"Ok","enroll again!"))
#3.For
friends <- c("Bee","Bright","Bliss")

for (friend in friends){
  print(paste ("Hi!",friend))
}
#vectorization -> take hi to paste on vector
paste ("Hi!",friends)

nums<-c(5,10,15,20,25)
(nums<- nums+2)
#4.While
count =0
while (count<5)
{
  print("Hi")
  count <-count+1
}
