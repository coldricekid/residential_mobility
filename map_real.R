library(maps)
library(ggplot2)
library(tidyverse)

usa <- map_data("usa")
states <- map_data("state")
counties <- map_data("county")



df <- state.x77 %>% as.data.frame() %>% rownames_to_column("state")
df$state <- tolower(df$state)

ggplot(combined, aes(map_id = States)) + geom_map(aes(fill = Estimates), map = states) +
  expand_limits(x = states$long, y = states$lat) +
  scale_fill_gradient(low = "white", high = "#FF5733") +
  labs(title = "Geographic Mobility of US Population in 2021", x = "longitude", y = "latitude",
       caption = "source: https://www.rdocumentation.org/packages/
       datasets/versions/3.6.1/topics/state") +
  coord_fixed(1.3) +
  theme(panel.background = element_blank())


