# week 9 homework
library(tidyverse)
library(lubridate)

# reading in Mauna Loa data from github
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

## Use the README file associated with the Mauna Loa dataset to determine in what time zone the 
## data are reported, and how missing values are reported in each column. 

# timezone is UTC
# missing data is reported with -999.9, or -99, or 

#1 
## With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, 
## and windSpeed_m_s. 
mloa_nona <- mloa %>%
  filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -99.9)

# 2
# Generate a column called “datetime” using the year, month, day, hour24, and min columns.

mloa_nona = mloa_nona %>%
  mutate(datetime = ymd(paste(year,month,day))) %>% # paste fxn -- pushes strings together, can be columns, etc
  mutate(datetime2 = ymd_hm(paste(datetime, " ",hour24,":",min)))

head(mloa_nona)
# 3
# Next, create a column called “datetimeLocal” that converts the datetime column to 
# Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). 
mloa_nonon = mloa_nona %>% 
  mutate(datetimeLocal = with_tz(datetime2, tz="Pacific/Honolulu"))



# 4
# Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column 
# and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()).

mloa_nooo <- mloa_nonon %>%
  mutate(localmonth = month(datetimeLocal, label=TRUE), 
  localhr = hour(datetimeLocal)) %>%
  group_by(localmonth, localhr) %>%
  summarise(mean_hr_temp = mean(temp_C_2m))

  
# 5
# Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by 
# local hour.

mloa_nooo %>%
  ggplot(aes(x = localmonth, y = mean_hr_temp)) +
    geom_point(aes(col = localhr)) +
    scale_color_viridis_c(option="A") +
    xlab("Month") +
    ylab("Mean Temp (deg C)") +
    theme_classic()


