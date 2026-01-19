#save object
#1.save all object in environment -> .Rdata
save.image(file="data.Rdata")
#load data back 
load(file="data.Rdata")

#2.save single object
saveRDS(bussiness,"bussiness.rds")
#load object back
bussiness <- readRDS("bussiness.rds")