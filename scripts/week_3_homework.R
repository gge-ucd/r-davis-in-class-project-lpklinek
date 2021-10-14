


# Load your survey data frame with the read.csv() function. 
# Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns. 
# Have this data frame only be the first 60 rows. Convert both species_id and plot_type to factors. 
# Explore these variables and try to explain why a factor is different from a character.
# Remove all rows where there is an NA in the weight column.

# CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.


surveys <- read.csv("data/portal_data_joined.csv") # reading csv file
head(surveys)
surveys_base1 <- surveys[(1:60), ] # selecting first 60 rows
surveys_base <- surveys_base1[, c(6, 9, 13)] # selecting the columns we want
surveys_base

# converting species_id and plot_type to factors
species_id_factor <- factor(surveys_base$species_id)
plot_type_factor <- factor(surveys_base$plot_type)

# how is a factor different from a character?
## still not entirely sure, but factors seem like they're charcters with a certain order inherent in their existence... as opposed to integers?

# removing all the rows with NA in the weight column
surveys_base_noNA <- surveys_base[!is.na(surveys_base)]
surveys_base_noNA
# or, for just weight column
surveys_base_noNA <- na.omit(surveys_base,surveys_base$weight)

# challenge -- selecting individuals with weights greater than 150
challenge_base <- surveys_base[(surveys_base[, 2]>150),]
challenge_base
challenge_base_new <- challenge_base[!is.na(challenge_base[, 2]),] # removing the NA weights oops
challenge_base_new

# something kind of got messed up with my surveys_base_noNA i think so i had to kind of re-remove the NAs from my challenge df, but got there eventually!