## looping and apply

  ##loop
#check col&row
nrow(USArrests)
ncol(USArrests)

for (i in 1:ncol(USArrests))
{print(names(USArrests[i]))
 print(mean(USArrests[[i]]))
}

cal_mean_by_col <- function(df)
{for (i in 1:ncol(df))
{print(names(df[i]))
  print(mean(df[[i]]))
}}

#refractor 

cal_mean_by_col2 <- function(df)
{
  col_names <-names(df)
  for (i in 1:ncol(df))
  {
    avg_col <- mean(df[[i]])
    print(paste(col_names[i],":",avg_col))
  }
}

  ##apply function
avg_by_col <-apply(mtcars,MARGIN = 2,mean)
sum_by_col <-apply(mtcars,MARGIN = 2,sum)
