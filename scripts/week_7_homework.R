library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") 

install.packages("wesanderson")
library(wesanderson)


gapminder %>% 
  select(country, year, pop, continent) %>% # selecting the good stuff
  filter(continent != "Oceania") %>% # dropping aus and nz 
  pivot_wider(names_from = year, values_from = pop) %>% # turning years into columns
  mutate(pop_change = `2007` - `2002`) %>% # creating pop change column -- need to use weird quotes because column names are numbers
  ggplot(aes(x = reorder(country, pop_change), y = pop_change))+ # making plots, ordering bars ascending
  geom_col(aes(fill = continent))+ # color of bars
  facet_wrap(~continent, scales = 'free')+ # making facets of each continent, w different y scales
  theme_minimal() + # cool theme
  scale_fill_manual(values = wes_palette("GrandBudapest2", n=4))+ # SUPER cool palette hehe
  theme(axis.text.x = element_text(angle = 45))+ # angling x axis labels
  xlab("Country")+ # x axis label
  ylab("Change in Population between 2002 and 2007") # y axis label


# can use coord_flip() to flip x and y