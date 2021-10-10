
# reading our spreadsheet
surveys <- read.csv("data/portal_data_joined.csv")

head(surveys)

class(surveys) #surveys is a dataframe
str(surveys) #13 columns, 34786 rows
# how are our character data represented in this df? as characters

#finding how many different species were observed
length(unique(surveys$species))


#converting something from a character to a factor
species_factor <- factor(surveys$species)
typeof(species_factor)
class(species_factor)
# factors are numbers, and they have an order
# have to order the levels?
levels(species_factor) #levels usually default to alphabetical order

# subsetting from a dataframe -- row, column
surveys_200 <- surveys[200,]
nrow(surveys)
surveys_last <- surveys[34786,]
34786 / 2
surveys_middle <- surveys[17393,]

surveys[-c(7:34786), ]
