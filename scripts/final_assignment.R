# Final Assignment
library(tidyverse)
library(lubridate)


# Reading in flights, planes, and weathers csv files
flights <- read_csv("data/nyc_13_flights_small.csv")
planes <- read_csv("data/nyc_13_planes.csv")
weather <- read_csv("data/nyc_13_weather.csv")

# Joining
weather <- weather %>%
  mutate(time_hour = ymd_h(paste(year,month,day,hour)))

flights_weather <- left_join(flights, weather, by = "time_hour")
head(flights_weather)

flight_info <- left_join(flights_weather, planes, by = "tailnum")
head(flight_info)

# Assignment objectives
# 1. Plot the departure delay of flights against the precipitation, and include a simple regression 
# line as part of the plot. Hint: there is a geom_ that will plot a simple y ~ x regression line 
# for you, but you might have to use an argument to make sure it’s a regular linear model. 
# Use ggsave to save your ggplot objects into a new folder you create called “plots”.

flight_info %>%
  ggplot(aes(x = precip, y = dep_delay)) +
  geom_point(color='green') +
  geom_smooth(method='lm', se=FALSE) +
  xlab("Precipitation") +
  ylab("Departure Delay (mins)") +
  theme_classic() +
  ggsave('figures/precip_dep_delay.png')


# 2. Create a figure that has date on the x axis and each day’s mean departure delay on the y 
# axis. Plot only months September through December. Somehow distinguish between airline 
# carriers (the method is up to you). Again, save your final product into the “plot” folder.

flight_info %>%
  select(year.x, month.x, day.x, dep_delay, carrier) %>%
  filter(month.x >= 9) %>%
  mutate(year_month_day = ymd(paste(year.x,month.x,day.x))) %>%
  group_by(year_month_day, dep_delay) %>%
  mutate(mean_dep_day = mean(dep_delay)) %>%
  ggplot(aes(x=year_month_day, y=mean_dep_day))+
  xlab("Date")+
  ylab("Mean Departure Delay (mins)")+
  geom_point(aes(color=carrier))+
  theme_minimal()+
  ggsave('figures/mean_dep_delay.png')



# 3. Create a dataframe with these columns: date (year, month and day), mean_temp, where each 
# row represents the airport, based on airport code. Save this is a new csv into you data folder 
# called mean_temp_by_origin.csv.


airport_temp <- weather %>%
  select(year, month, day, origin, temp) %>%
  filter(!is.na(temp)) %>%
  group_by(origin) %>%
  summarize(mean_temp = mean(temp)) %>%
  write_csv('data_output/mean_temp_by_origin.csv')


# 4. Make a function that can: (1) convert hours to minutes; and (2) convert minutes to hours 
# (i.e., it’s going to require some sort of conditional setting in the function that determines 
# which direction the conversion is going). Use this function to convert departure delay 
# (currently in minutes) to hours and then generate a boxplot of departure delay times by 
# carrier. Save this function into a script called “customFunctions.R” in your scripts/code 
# folder.

min_hour <- function(time, unit) {
  if (unit == 'hour') {new_time = time * 60}
  else {new_time <- time / 60}
  return(new_time)
}

min_hour(120, unit='minute')
save(min_hour='scripts/min_hour.R')

# 5. Below is the plot we generated from the new data in Q4. 
# (Base code: ggplot(df, aes(x = dep_delay_hrs, y = carrier, fill = carrier)) +   geom_boxplot()).
# The goal is to visualize delays by carrier. Do (at least) 5 things to improve this plot by 
# changing, adding, or subtracting to this plot. The sky’s the limit here, remember we often 
# reduce data to more succinctly communicate things.


flight_info %>%
  select(year.x, month.x, day.x, dep_delay, carrier) %>%
  filter(month.x >= 9) %>%
  mutate(year_month_day = ymd(paste(year.x,month.x,day.x))) %>%
  group_by(carrier, dep_delay) %>%
  mutate(mean_dep_delay = mean(dep_delay)) %>%
  mutate(mean_dep_delay_hr = min_hour(mean_dep_delay, unit='minute')) %>%
  ggplot(aes(x = mean_dep_delay_hr, y = carrier, fill = carrier)) +
  ylab("Carrier")+
  xlab("Mean Departure Delay (hrs)")+
  geom_boxplot(alpha = 0.8)+
  theme_minimal()+
  ggtitle("Flight Departure Delays")+
  theme(plot.title = element_text(hjust = 0.5))


