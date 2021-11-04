library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") 
#ONLY change the "data" part of this path if necessary

## 1
# First calculate mean life expectancy on each continent. Then create a plot that shows how life 
# expectancy has changed over time in each continent. Try to do this all in one step using pipes! 
# (aka, try not to create intermediate dataframes)
gapminder %>% 
  group_by(continent, year) %>%
  summarize(meanlifeExp = mean(lifeExp)) %>%
  ggplot()+
  geom_line(aes(x = year, y = meanlifeExp, color = continent))


## 2
# Look at the following code and answer the following questions. 
# What do you think the scale_x_log10() line of code is achieving? 
# What about the geom_smooth() line of code?


ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# scale_x_log10 changes the scale of the x axis to better represent GDP per capita
# geom_smooth() adds a linear fit to the scatterplot



## 3
# Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and 
# the United States, with the data points in the backgroud using geom_jitter. Label the X and 
# Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five 
# Countries”.

c = c("Brazil", "China", "El Salvador", "Niger", "United States")

gapminder %>%
  filter(country %in% c) %>%
  ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot()+
  geom_jitter(alpha = 0.2)+
  theme_classic()+
  ggtitle("Life Expectancy of Five Countries")+
  theme(plot.title = element_text(hjust = 0.5))+ 
  xlab("Country") + ylab("Life Expectancy") 
  
  


