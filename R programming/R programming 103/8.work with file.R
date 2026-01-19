  ## work with file
library(readr)
#1.Text file
#white space seperate value data
student <- read_table("student.txt")
View(student)

#2. csv file
#comma seperate value data

#3.Excel file
library(readxl)
#can specific open sheets in file by sheet number
read_excel("students.xlsx",sheet=1)
# or name
read_excel("students.xlsx",sheet="Economics")
econ_student <-read_excel("students.xlsx",sheet="Economics")

#read file and keep in list
result <- list()
for (i in 1:3)
{
  result[[i]] <- read_excel("students.xlsx",sheet=1)
}
#subset data 
result[[2]]

#5.google sheets
library(googlesheets4)
url <- "https://docs.google.com/spreadsheets/d/1O9DWiLvtvDxXr_rzJRf6UnKrem3d3eaXZVenMlMJ8ZQ"
#for public link used deauth no need login 
gs4_deauth()
read_sheet(url,sheet=1)

#6.JSON
library(jsonlite)
#json read file in as list
fromJSON("tealiker.json")
#wrap with df
tea_liker <- data.frame(fromJSON("tealiker.json"))