#load library
library(sqldf)
library(readr)

#read file
#sqldf is covert sql statment to manipulate df
school <-read_csv("school.csv")
sqldf("select * from school;")
sqldf("select 
      avg(student),
      sum(student) from school;")

sqldf("select school_id,
      school_name,country from school")

#technique
sql_statement <- "select * from school 
where country ='UK';"
sqldf(sql_statement)