library(tidyverse)
df1 <- read_csv('Raw Data/long_data.csv')  
df1$`Label (Grouping)` <- str_trim(df1$`Label (Grouping)`, 'left')
  

estimates_only <- df1 %>% filter(`Label (Grouping)` == 'Estimate') %>%
  filter(!grepl('%',`Population 1 year and over`)) %>%
  rename('Estimates' = `Population 1 year and over`) %>%
  select(Estimates) %>%
  mutate(x = row_number())

states_only <- df1 %>% filter(`Label (Grouping)` != 'Total',
                              `Label (Grouping)` != 'Margin of Error',
                              `Label (Grouping)` != 'Moved; from different county, same state',
                              `Label (Grouping)` != 'Estimate',
                              `Label (Grouping)` != 'Moved; from different  state',
                              `Label (Grouping)` != 'Moved; from abroad',
                              `Label (Grouping)` != 'Moved; within same county') %>%
  rename('States' = `Label (Grouping)`) %>%
  select(States) %>% 
  mutate(x = row_number())

combined <- states_only %>% left_join(estimates_only, by='x') %>% select(-x) %>%
  filter(States != 'Puerto Rico') %>%
  mutate(Estimates = as.numeric(gsub(',','',Estimates)))

combined$States <- tolower(combined$States) 
#PR is missing in original dataset so NA is ok. Can remove

