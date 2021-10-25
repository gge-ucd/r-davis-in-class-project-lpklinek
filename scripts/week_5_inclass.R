library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

# finding mean
summary(surveys$hindfoot_length)

# splitting df at mean
## if... (True / False statement), then... (label true as:, false as:)
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < 29.29, "small", "big")
head(surveys$hindfoot_cat)


# case when
# for the case when.... do this. then for all others (TRUE), do this.
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()


# fixing this to assign NA's as NA, not as a TRUE
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    is.na(hindfoot_length) ~ NA_character_,
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()


# challenge 1
head(iris)
summary(iris$Petal.Length)
iris %>% 
  mutate(petal_length_cat = case_when(
    Petal.Length < 1.6 ~ "small",
    Petal.Length > 1.6 & Petal.Length < 5.1 ~ "medium",
    is.na(Petal.Length) ~ NA_character_,
    TRUE ~ "large"
  )) %>% 
  select(Petal.Length, petal_length_cat) %>% 
  head()


# joining dfs


tail <- read_csv("data/tail_length.csv")
summary(surveys$record_id) #just summarize the record_id column by using the $ operator 
summary(tail$record_id)

surveys_joined <- left_join(surveys, tail, by = "record_id")

NL_data <- surveys %>% 
  filter(species_id == "NL") #filter to just the species NL

NL_data <- left_join(NL_data, tail, by = "record_id") #a new column called tail_length was added


#pivoting
surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))
str(surveys_mz) #let's take a look at the data
unique(surveys_mz$genus) #lists every unique genus in surveys_mz
n_distinct(surveys_mz$genus) #another way to look at the number of distinct genera
n_distinct(surveys_mz$plot_id)
wide_survey <- surveys_mz %>% 
  pivot_wider(names_from = "plot_id", values_from =  "mean_weight")

head(wide_survey)
#cols = columns to be pivoted. Here we want to pivot all the plot_id columns, except the colum "genus"
#names_to = the name of the new column we created from the `cols` argument 
#values_to = the name of the new column we will put our values in

surveys_long <- wide_survey %>% 
  pivot_longer(col = -genus, names_to = "plot_id", values_to = "mean_weight")
View(surveys_long)
surveys_long <- surveys_long %>% 
  filter(!is.na(mean_weight)) #now 196 rows




#challenge 2
# 1
## Use pivot_wider on the surveys data frame with year as columns, plot_id as rows, and the number
## of genera per plot as the values. You will need to summarize before reshaping, and use the 
## function n_distinct() to get the number of unique genera within a particular chunk of data. 
## It’s a powerful function! See ?n_distinct for more.

surveys_gen <- surveys %>% 
  filter(!is.na(genus)) %>% 
  group_by(plot_id, year) %>% 
  summarize(n_genus = n_distinct(genus)) %>% 
  pivot_wider(names_from = "year", values_from = "n_genus")

head(surveys_gen)


# 2
## The surveys data set has two measurement columns: hindfoot_length and weight. 
## This makes it difficult to do things like look at the relationship between mean values of 
## each measurement per year in different plot types. Let’s walk through a common solution for 
## this type of problem. First, use pivot_longer() to create a dataset where we have a new column
## called measurement and a value column that takes on the value of either hindfoot_length or 
## weight. Hint: You’ll need to specify which columns are being selected to make longer.



surveys_meas <- surveys %>%
  filter(!is.na(hindfoot_length), !is.na(weight)) %>% # filtering out NAS
  # then want to select which columns we want, then name our new "type" column and the value column
  pivot_longer(cols = c("hindfoot_length", "weight"), names_to = "measurement", values_to = "value") %>% 
  select(measurement, value, year, plot_type)

head(surveys_meas)

# 3
## With this new data set, calculate the average of each measurement in each year for each 
## different plot_type. Then use pivot_wider() to get them into a data set with a column for 
## hindfoot_length and weight. Hint: You only need to specify the names_from = and values_from = 
## columns

surveys_meas_wide <- surveys_meas %>% 
  group_by(year, plot_type, measurement) %>% # will make a new row for each measurement type
  summarize(average_value = mean(value)) %>% # calculating mean values of weight or hindfoot
  pivot_wider(names_from = "year", values_from = "average_value")

head(surveys_meas_wide)
  


# to export datasets as files, use write_csv()

