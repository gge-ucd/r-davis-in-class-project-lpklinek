install.packages('tidyverse')
library(tidyverse)
install.packages('lubridate')
library(lubridate)
install.packages('dplyr')
library(dplyr)

# loading data with tidyverse package read_csv
surveys <- read_csv("data/portal_data_joined.csv")

## inspect the data
str(surveys)


# select = rows
# filter = columns
select(surveys, plot_id, species_id, weight)
filter(surveys, year == 1995)

# piping -- start w/ the df you want to use, then list your functions w pipe between
surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)


# challenge
## Using pipes, subset the surveys data to include individuals collected before 1995 and retain 
## only the columns year, sex, and weight. Name this dataframe surveys_challenge

surveys_challenge <- surveys %>%
  filter(year < 1995) %>%
  select(year, sex, weight)
surveys_challenge

# challenge 2
## Create a new data frame from the surveys data that meets the following criteria: 
## contains only the species_id column and a new column called hindfoot_half containing 
## values that are half the hindfoot_length values. In this hindfoot_half column, there are no 
## NAs and all values are less than 30. Name this data frame surveys_hindfoot_half


surveys_hindfoot_half <- surveys %>%
  mutate(hindfoot_half = hindfoot_length / 2) %>%
  na.omit(hindfoot_half) %>%
  filter(hindfoot_half < 30) %>%
  select(species_id, hindfoot_half) 
surveys_hindfoot_half


# group by
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
# can also group by multiple columns


# challenge 3
## Use group_by() and summarize() to find the mean, min, and max hindfoot length for each species
## (using species_id).
## What was the heaviest animal measured in each year? Return the columns year, genus, species_id, 
## and weight.
## You saw above how to count the number of individuals of each sex using a combination of 
## group_by() and tally(). How could you get the same result using group_by() and summarize()? 
## Hint: see ?n.

surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(species_id) %>%
  summarize(mean_length = mean(hindfoot_length, na.rm = TRUE), 
            min_length = min(hindfoot_length, na.rm = TRUE),
            max_length = max(hindfoot_length, na.rm = TRUE))

surveys %>%
  filter(!is.na(weight)) %>%
  group_by(year) %>%
  filter(weight == max(weight)) %>% # asking to only show the max weight in each yr
  select(year, genus, species, weight) %>%
  arrange(year)

surveys %>%
  group_by(sex) %>%
  summarize(number = n())
  



