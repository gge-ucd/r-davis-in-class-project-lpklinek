# week 4 homework

# install.packages('tidyverse')
library(tidyverse)
# install.packages('lubridate')
library(lubridate)
# install.packages('dplyr')
library(dplyr)

# 1
# Create a tibble named surveys from the portal_data_joined.csv file.

surveys <- read_csv("data/portal_data_joined.csv")

# 2
# Subset surveys to keep rows with weight between 30 and 60, and print out the first 6 rows.
head(filter(surveys, weight > 30, weight < 60))

# 3
# Create a new tibble showing the maximum weight for each species + sex combination and name
# it biggest_critters. Sort the tibble to take a look at the biggest and smallest species + sex 
# combinations. HINT: it’s easier to calculate max if there are no NAs in the dataframe…

biggest_critters1 <- read_csv("data/portal_data_joined.csv")
biggest_critters <- biggest_critters1 %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  summarise(max_weight = max(weight))

# ascending
biggest_critters %>% arrange(max_weight)
# descending
biggest_critters %>% arrange(desc(max_weight))
  

# 4
# Try to figure out where the NA weights are concentrated in the data- is there a particular 
# species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily 
# a right or wrong answer here, but manipulate surveys a few different ways to explore this. 
# Maybe use tally and arrange here.

# species
surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species_id) %>% 
  tally() %>% 
  arrange(desc(n))

# plot
surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))

# 5
# Take surveys, remove the rows where weight is NA and add a column that contains the average 
# weight of each species+sex combination to the full surveys dataframe. Then get rid of all the 
# columns except for species, sex, weight, and your new average weight column. Save this tibble 
# as surveys_avg_weight.

surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  mutate(avg_weight = mean(weight), na.rm = TRUE) %>%
  select(species_id, sex, weight, avg_weight)

surveys_avg_weight


# 6
# Take surveys_avg_weight and add a new column called above_average that contains logical values 
# stating whether or not a row’s weight is above average for its species+sex combination (recall 
# the new column we made for this tibble).


surveys_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > avg_weight) #adding a new column that answers if weight > average

surveys_avg_weight



