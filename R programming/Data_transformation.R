    ## data transformation ##
#call library
library(lubridate)
library(dplyr)
library(glue)

#string interpolation
name<- "bright"
age<-23
text<-glue("hi my name is {name}
           and i'm {age}years old")
print(text)

#regular expression
##pattern matching 
state.name
#return the index of data that match pattern
index <- grep("^A",state.name)
state.name[index]

#return true/false
index<-grepl("^A",state.name)
state.name[index]
#start with 'new' end with e
grep("^New.+e$",state.name)
#value = true -> get data
#=false -> index
grep("^New",state.name,
     ignore.case = TRUE
     ,value = TRUE)

    ##lubridate (manage date datatype)
  ##change test to date
text_date <- '2026-03-02'
class(text_date)
d1<-ymd(text_date)
d1
  #extract part of date
year(d1)
#label:get name ,abbr :short form
month(d1,label = TRUE,abbr = FALSE)
day(d1)
#get weeks day
wday(d1,label = TRUE)
  #messy date
mdy("October,11-2025")
dmy("11 oct 2025")
mdy("10/11/2025")
dmy("11.10.2025")
myd("oct, 2025 11")

    ##library dplyr
#select ,filter,arrange,mutate,summarise
#+ group by + join
View(mtcars)

  #get row name 
row.names(mtcars)
  #create new column 
mtcars$model <- row.names(mtcars)
row.names(mtcars)<- NULL

  #preview data set
head(mtcars,6)
tail(mtcars,6)

  ##1. select column 
select(mtcars,1:3)
help(select)
select(mtcars,model,hp,wt)
  #subset by condition : insensitive case
select(mtcars,contains("a"))
select(mtcars,starts_with("p"))
select(mtcars,ends_with("h"))
  #move column
#everything() -> bring everything else column to right side
mtcars<- select(mtcars,model
                ,everything())
  #change name 
#new name = old name 
select(mtcars,horse_power=hp,
       weight=wt)
#get everything & change the col name
rename(mtcars,weight=wt)

  #use sql to transform
library(sqldf)
sqldf("select model,hp as horse_power from mtcars limit 10")
      
  ##pipe operator %>% : code chaining 
#short cut : ctrl + shift+m
mtcars %>% 
  select (model,hp,wt,am) %>%
  filter(hp >100)%>% 
  arrange(desc(hp))%>%
  head(10)
#0r another version 
mtcars |>
  select (model,hp,wt,am) |>
  filter(hp >100)|>
  arrange(desc(hp))|>
  head(10)

  ##2. filter : filter data by condition(s)
#single condition
select(mtcars,hp,wt,am) %>%
  filter(hp>100)
#multiple condition
#AND condition
select(mtcars,hp,wt,am) %>%
  filter(hp>100 & wt>=3)
#OR condition
df2<- select(mtcars,hp,wt,am) %>%
  filter(hp>100 | wt>=3 &am==1)
## explore filter to do more
mtcars %>% 
  select (model,hp,wt,am) %>%
  filter(grepl("^A",model))

mtcars %>% 
select (model,hp,wt,am) %>%
  filter(!grepl("^A",model))

    ##3.Mutate : create new column
#the create column will be at the right side 
#if not used name then it will be rewrite on the exist column
help("mutate")
mtcars |> 
  select(model,hp)|>
  head(10)|>
  mutate(hp_double = hp*2)
#mutate can create multiple column in same time 
mtcars |> 
  select(model,hp)|>
  head(10)|>
  mutate(hp_log = log(hp),
         hp_100=hp+100,
         hp_100_2=hp_100*2)

mtcars |> 
  select(model,hp,am) |>
  mutate(am=if_else(am==0,"Auto"
                    ,"Manual")) |>
  head(10)

#create segment for hp :low, medium ,high
#case when con ~ then 
#true is else
mtcars |> 
  select(model,hp,am) |>
  mutate(segment=case_when(
    hp>=200~"high",
    hp>=100~ "Medium",
    hp<100 ~ "Low",
    TRUE~ "other"
  ))

    ##4. Arrange : sorting low-to-high (default)
mtcars %>%
  select (model,am,hp) %>%
  filter(hp>100)%>%
  #arrange(hp)
  arrange(desc(hp))
#multiple sort : left -> right 
mtcars %>%
  select (model,am,hp) %>%
  filter(hp>100)%>%
  arrange(am,hp)

mtcars %>%
  select (model,am,hp) %>%
  filter(hp>100)%>%
  #sort hp high-to-low
  arrange(am,-hp)

    ##5. Summarise :aggregate func. in SQL
mtcars %>%
  summarise(avg_hp=mean(hp),
            sum_hp=sum(hp),
            min_hp=min(hp),
            max_hp=max(hp),
            #count = count (*)
            n=n(),
            sd_hp=sd(hp),
            med_hp=median(hp))

# + group by (before summarize!)
mtcars %>% 
  mutate(am =if_else(am==0,"auto",
                     "manual"))%>%
  group_by(am)%>%
  summarise(avg_hp=mean(hp),
            sum_hp=sum(hp),
            min_hp=min(hp),
            max_hp=max(hp),
            #count = count (*)
            n=n())

    ##5 function good to knows
#check some data 
glimpse(mtcars)
summary(mtcars)
#change df to tibble
#pattern show ..more clean
tibble(mtcars)
#count for create frequency table
library(ggplot2)
diamonds

diamonds %>%
  count(cut,sort=TRUE)
#find the percentage of n
diamonds %>%
  count(cut,sort=TRUE) %>%
  mutate(pct=n/sum(n))
#sample
#set seed lock the random data
set.seed(42)
diamonds %>%
  sample_n(5)

#sample by percentage
diamonds %>% 
  sample_frac(0.2)

    ##Join data
## inner,left,right,full
band_members
band_instruments
#inner join 
band_members %>%
 inner_join(band_instruments,
            by="name")
#left join
band_members %>%
  left_join(band_instruments,
            by="name")
#right join
band_members %>%
  right_join(band_instruments,
             by="name")
#full join
band_members %>%
  full_join(band_instruments,
            by="name")
  ##semi & anti join : filtering join
#semi join
#find row in table x 
#and exist in table y
band_members %>%
  semi_join(band_instruments,
            by="name")
#anti join
#find row in x that didnt exist in y
band_members %>%
  anti_join(band_instruments,
            by="name")

  ## bind_row , bind_col
df1<- data.frame(
  id =1:3,
  name=c("wawiss","wariss","woraniss")
)

df2 <- data.frame(
  id =4:6,
  name=c("suchala","wiriya","lalin")
)
#bind_row == union all (SQL)
bind_rows(df1,df2)
#bind_col lego press data
bind_cols(df1,df2)

#long vs wide format
#matrix format
WorldPhones

wp <- WorldPhones %>%
  as.data.frame() %>%
  #. represent df in previous steps
  mutate(year=rownames(.))
rownames(wp)<- NULL
#wide -> long 
library(tidyr) #long to wide,wide to long 
library(tibble) # rowname to column
long_wp <- WorldPhones %>%
  as.data.frame() %>%
  rownames_to_column(var="year")%>%
  pivot_longer(N.Amer:Mid.Amer,
               names_to = "Region",values_to = "Sales")
  
#long -> wide
wide_wp <- long_wp %>% 
  pivot_wider(names_from = "Region",values_from = "Sales")

    ##handle missing value
mini_df <- mtcars %>%
  select(model,hp,wt) %>%
  tibble()
#manual make na
mini_df[3,2]<-NA
mini_df[6,3]<-NA
#drop na (tidyr)
drop_na(mini_df)
#mean imputation 
#na.rm is to tell it to remove na before find mean
avg_hp<-mean(mini_df$hp,na.rm = TRUE)
#filter missing value
mini_df %>% 
  filter(is.na(hp))
#replace missing value
mini_df%>%
  mutate(hp=replace_na(hp,avg_hp),
         wt=replace_na(wt,mean(wt,na.rm=T))
  )




    ## file management ##
#read/write file
library(readr)
write_csv(df2,"df2_result.csv")
read_csv("df2_result")
#manage excel file
library(readxl)
read_excel("employee.xlsx",sheet=1)
#manage json
library(jsonlite)
#fromJSON("filename")
#manage gg sheets
library(googlesheets4)
#read_sheet(url,sheet)
