library(tidyverse)
surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + geom_point()


# Assign plot to a variable
surveys_plot <- ggplot(data = surveys_complete, 
                       mapping = aes(x = weight, y = hindfoot_length))

# Draw the plot -- This is the correct syntax for adding layers
surveys_plot + 
  geom_point()


# This will not add the new layer and will return an error message
surveys_plot
+ geom_point()

# adding transparency -- alpha
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)

# adding color
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")
# adding color for each species_id
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))
# version with the aes fxn inside the ggplot
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_point(alpha = 0.1)



# Challenge 1
# Use what you just learned to create a scatter plot of weight and species_id with weight on the 
# Y-axis, and species_id on the X-axis. Have the colors be coded by plot_type. Is this a good way
# to show this type of data? What might be a better graph?


ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + 
  geom_point(alpha = 0.1, aes(color = plot_type))

# this could be better by separating the graph into multiple panels, one for each plot type
ggplot(surveys_complete, aes(x = species_id, y = weight)) +
  geom_point() +
  facet_wrap(~plot_type)

# could change the theme 
ggplot(surveys_complete, aes(x = species_id, y = weight)) +
  geom_point() +
  theme_classic()







# Box plots
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot()

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato") #notice our color needs to be in quotations

# Challenge 2

# violin plots, with a log scale for weight
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_violin(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  scale_y_log10()

#overlaying a jitter plot of hindfoot lengths by a box plot, then coloring datapoints by plot
surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF") %>% # selecting two specific species -- using boolean OR
  ggplot(mapping = aes(x= species_id, y = hindfoot_length)) + # making the scatterplot
  geom_jitter(alpha = 0.2, aes(color = as.factor(plot_id))) + # color by plot, need to convert to factor so it can be categorical and not continuous
  geom_boxplot() #overlaying a box plot




# time series
yearly_counts <- surveys_complete %>%
  count(year, species_id) 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line()

#now need to group by species
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line()

# adding color to distinguish between species
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = species_id)) +
  geom_line()





# faceting
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)

# Challenge 3





# themes
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(x = "Year",
       y = "Count",
       title = "Annual Count") #changing axes and title

# full list of themes: http://docs.ggplot2.org/current/ggtheme.html 





