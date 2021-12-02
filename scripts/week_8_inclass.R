library(dplyr)
library(readr)


sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
#notice we have dates across two years here


#turn into real datetimes
sample_dates_1 <- as.Date(sample_dates_1)

# to specify format
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")

sample_dates_3<- as.Date(sample_dates_2, format = "%m-%d-%Y" ) # date code preceded by "%"


# base R class for datetimes
tm1 <- as.POSIXct("2016-07-24 23:55:26")
tm1

# specific formatting
tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2

# can specify timezone with tz = "GMT"

# install.packages("lubridate")
library(lubridate)

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
sample_dates_lub <- ymd(sample_dates_1)

sample_dates_2 <- c("2-01-2018", "3-21-2018", "10-05-18", "01-01-2019", "02-18-2019")
#notice that some numbers for years and months are missing

sample_dates_lub2 <- mdy(sample_dates_2) #lubridate can handle it! 

# for time and timezones
# To the ymd function, add _hms or _hm (h= hours, m= minute, s= seconds) and a tz argument. 
# lubridate will default to the POSIXct format.

# import raw dataset & specify column types
# see lecture materials for rest of the example code
