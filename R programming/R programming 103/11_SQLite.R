#load library
library(RSQLite)

# connect to SQLite database (.db file)
#1. Open connection
conn<-dbConnect(SQLite(),"chinook.db")

#2. get data
#get table name in connection
dbListTables(conn)
#get col in table
dbListFields(conn,"customers")
#get data
df_customer <- dbGetQuery(conn,"select * from customers where Country='USA'")
View(df_customer)

#3. close connection
dbDisconnect(conn)