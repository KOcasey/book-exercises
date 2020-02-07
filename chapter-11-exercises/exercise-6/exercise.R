# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")
View(airports)
# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
avg_arr_delay_dest <- flights %>% 
  group_by(dest) %>% 
  summarize(arr_delay = mean(arr_delay, na.rm = TRUE))

avg_arr_delay_airport <- left_join(airports, avg_arr_delay_dest, by = "name")

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
avg_arr_delay_airline <- flights %>% 
  group_by(carrier) %>% 
  summarize(arr_delay = mean(arr_delay, na.rm = TRUE))

avg_arr_delay_per_airline <- left_join(airlines, avg_arr_delay_airline, by = "carrier")
print(avg_arr_delay_per_airline %>% 
        filter(arr_delay == min(arr_delay)))
