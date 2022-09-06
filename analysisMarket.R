library(dplyr)

#import the csv dataset and view clearly
mrtdf = read.csv("mkt_df.csv", sep = ';',  fileEncoding="UTF-8-BOM", head = TRUE)
View(mrtdf)


#clear the data
desired_columns <-c(1, 4, 7)
markdfcleanmain <- mrtdf[desired_columns]
View(markdfcleanmain)
markdfclean <- mrtdf[desired_columns]
View(markdfclean)

#check class is still data frame
class(markdfclean)

#rename columns names
colnames(markdfclean) <- c("date", "channel", "spend")
View(markdfclean)

#r reads these values
str(markdfclean)


#force lowercase channel character column
markdfclean$channel <- tolower(markdfclean$channel)
#check all unique channel names specified in the channel column
unique(markdfclean$channel)


#gsub() function in R is used to replace the strings with input strings or values.
#rename "not tracked" to "direct"
markdfclean$channel <- gsub("not tracked","direct",markdfclean$channel)

#rename "unpaid" to "organic"
markdfclean$channel <- gsub("unpaid","organic",markdfclean$channel)

#rename "silverpop" to "email"
markdfclean$channel <- gsub("silverpop","email",markdfclean$channel)

#shorten facebookbusinessadsmanager to just "facebook" as there are no other FB activity in here
markdfclean$channel <- gsub("facebookbusinessadsmanager","facebook",markdfclean$channel)

#check
View(markdfclean)


#set dates to year-month-day using ymd() from lubridate library use to convert int to data type
library(lubridate)
# year month day
markdfclean$date <- ymd(markdfclean$date)
#now check the class of this column. must be date
class(markdfclean$date)

# check all column formats
str(markdfclean)

#spend column is string for some reason. There are commas in there which should be turned into decimals.
markdfclean$spend <- as.numeric(gsub("," , ".", markdfclean$spend))

# check column formats
str(markdfclean)

#check again. 
View(markdfclean)

#We want make sure there is only 1 channel per day, and the spend is the total spend for that channel in that day.
markdfclean <- aggregate(spend ~ date + channel, data = markdfclean, sum)
head(markdfclean)
tail(markdfclean)


