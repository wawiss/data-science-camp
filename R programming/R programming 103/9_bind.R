  #import library
library(dplyr)
library(readxl)

  #read excel file
econ <- read_excel("students.xlsx",sheet=1)
bussiness <- read_excel("students.xlsx",sheet=2)
data <- read_excel("students.xlsx",sheet=3)

  #1.binds row
#bind row (R) == union all (SQL)
#n_cols is equal & data type is same
bind_df <- bind_rows(econ,bussiness,data)

#short version by make df list
list_df <-list(econ,bussiness,data)
full_df <- bind_rows(list_df)

  #2.bind cols
#bind cols(R) != join (SQL)
#concat df without use key

df1 <- data.frame(
  id=1:3,
  tea=c("black tea","white tea","grean tea")
)

df2<- data.frame(
  city= c(rep("Uji",2),rep("London",1)),
  country=c(rep("Japan",2),rep("UK",1))
)
tea_time <- bind_cols(df1,df2)