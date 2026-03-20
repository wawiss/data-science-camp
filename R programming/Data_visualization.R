library(tidyverse)
library(RSQLite)


    ##connect sqlite db
#create connection
conn<- dbConnect(SQLite(),"chinook.db")
#get table 
dbListTables(conn)
#get column
dbListFields(conn,"customers")
#get data
df1<- dbGetQuery(conn,"select FirstName,LastName,
           City from customers limit 10")

df1 %>%
  filter(City=="London")
#join tables
df2<-dbGetQuery(conn,"select t1.customerid, 
                sum(total) as total_invoice
                from customers t1
                join invoices t2
                on t1.customerid = t2.customerid
                group by 1
                order by 2 desc " )

t1<- dbGetQuery(conn,"select * from customers")
t2<- dbGetQuery(conn,"select * from invoices")

t1 %>%
  left_join(t2,by="CustomerId") %>%
  group_by(CustomerId,Firstname,Lastname) %>%
  summarise(total_invoice=sum(Total)) %>%
  View()

#clean col name
library(janitor)
clean_names(t1) %>%
  head()

    ## Grammar of graphic (ggplot2) =2D
#ggplot in tidyverse

#how to select chart
#1.number of variable
#2. data type of each variable
View(diamonds)

  ## one variable , number
#mapping is to map data into element graph
#graph = data+ mapping+geom
ggplot(data=diamonds,
       #aes is aesthetic of graph
       mapping = aes(x=price)) +
       #render chart
       geom_histogram()

base<-ggplot(data=diamonds,
             #aes is aesthetic of graph
             mapping = aes(x=price))

base + geom_histogram(bins = 35) #default 30

base + geom_density()
base+geom_freqpoly()

#discrete vs continuous
#discrete is solid full number
#continuous is data continuous like height=172.343

  ##one variable ,factor (discrete)
diamond_bar <- ggplot(diamonds,
       aes(x=cut)) + 
       geom_bar()

  ## two variable ,both number
##scatter plot
ggplot(data=diamonds,
       aes(x=price,y=carat)) +
       geom_point()


#mini diamond
set.seed(42)
mini_diamonds <- sample_n(diamonds,
                          2000)

#get sample from full data
ggplot(mini_diamonds,
       aes(x=price,y=carat)) +
  geom_point()

#data overlap "over plotting"
#setting (set data not involve col) 
#vs mapping (map col to chart)
ggplot(data=mini_diamonds,
       mapping=aes(x=price,y=carat)) +
  #setting graph attribute
  geom_point(color="blue",alpha=0.3,
             size=3)

#bad graph ->too many thing
ggplot(data=mini_diamonds,
       #map the 3rd variable to graph
       mapping=aes(x=price,y=carat,
                   color=cut,
                   #add 4th variable as shape
                   #can do != good to do!!
                   shape=color)) +
  #setting graph attribute
  geom_point()

#if data is continuous -> color scale
ggplot(data=mini_diamonds,
             mapping=aes(x=price,
                         y=carat,
                   color=depth
                   )) +
  geom_point(alpha=0.35,size=3) +
  #set the color for color scale
  scale_color_gradient(low="gold",
                       high="red") +
  theme_minimal()

    ##multiple chart in one
base<-ggplot(mini_diamonds,
             aes(x=price, y=carat)) +
       theme_minimal()

base+ geom_point(alpha=0.25) +
       geom_smooth(method="loess",
                   color="blue",
                   se=FALSE)

    #want to make catergory has diferent color
  # method 01 : mutate
set.seed(42)
diamonds %>%
  mutate(price_rank=if_else
         (price>=10000,"High","Low")) %>%
        sample_n(500)%>%
        ggplot(data=.,
    mapping=aes(x=price,y=carat
        ,color=price_rank))+
        geom_point() +
        #set color of plot
        #scale -> adjust something
        scale_color_manual(values=c("red","gold"))+
        theme_minimal()

  #method 02 : call geom_...() twice
dm2<- sample_n(diamonds,2000)
ggplot() +
  geom_point(data=filter(dm2,price>=10000),
             mapping=aes(x=price,y=carat),
             color="blue") +
  geom_point(data=filter(dm2,price<10000),
             mapping=aes(x=price,y=carat)
             ,color="purple") +
  theme_minimal()
  
  ##stack bar in ggplot
##2 variable,both discrete
diamonds %>% 
  count(cut,color)

ggplot(diamonds,
       mapping= aes(x=cut,fill=color))+
  geom_bar() +
  theme_minimal()

#change to percent + label
ggplot(diamonds,
       mapping= aes(x=cut,fill=color))+
  #change to 100% stack
  geom_bar(position = "fill") +
  theme_minimal() +
  #add graph title,label
  labs(x="Cut queality",
       y="Propotion",
       title = "stacked bar chart",
       subtitle = "wawiss first graph ><")

# stack dodge
ggplot(diamonds,
       mapping= aes(x=cut,fill=color))+
  #change to 100% stack
  geom_bar(position = "dodge") +
  theme_minimal() +
  #add graph title,label
  labs(x="Cut queality",
       y="Propotion",
       title = "stacked bar chart",
       subtitle = "wawiss first graph ><")

  ##box plot, violin plot
#2 variable discrete and continuous
#find average price per cut

#five number summary
#min,q1,q2(median),q3,max
diamonds %>% group_by(cut)%>%
  summarise(min = min(price),
            q1=quantile(price,0.25),
            q2=quantile(price,0.5),
            q3=quantile(price,0.75),
            max=max(price))

#box plot : x =discreet ,y= continuous          
#detect outlier and data spread
ggplot(diamonds,
       mapping=aes(x=cut,y=price)) +
  geom_boxplot()

#violin plot : for data distribution
ggplot(diamonds,
       mapping=aes(x=cut,y=price,
                   fill=cut)) +
  geom_violin()


  ##facet 
#the most powerful technique in r
#extract chart into small particle
set.seed(42)
ggplot(data=diamonds %>% 
         sample_n(5000),
       mapping=aes(x=carat,y=price)) +
  geom_point() +
  #cut chart to cut catergory
  facet_wrap(~cut,ncol=5)+
  theme_minimal()

set.seed(42)
ggplot(data=diamonds %>% 
         sample_n(5000),
       mapping=aes(x=carat,y=price)) +
  geom_point(color='red',alpha=0.25) +
  geom_smooth(color='black') +
  #cut chart for multiple catergory
  facet_grid(cut~color)+
  theme_minimal()


        
    ##short cut function : qplot
#used for basic chart
qplot(x=cut,data=diamonds,geom="bar")
qplot(x=price,data=diamonds,
      geom="density")

help(qplot)
    ## theme 
#built-in theme in ggplot
#gg theme : it like layer stack on top of other layer
diamond_bar + theme_minimal()
##gg theme
library(ggthemes)
diamond_bar + theme_excel_new()
diamond_bar +theme_economist()

##color palette
ggplot(diamonds %>% sample_n(300),
       aes(x=carat,y=price,color=cut))+
  geom_point(size=2,alpha=0.6)+
  #seq for ambrient 
  #qual for competition
  scale_color_brewer(type = "seq",
                     palette=1) +
  theme_minimal()
