# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")
View(nycflights13::flights)
# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
dep_delay_by_month <- flights %>% 
  group_by(month) %>% 
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE))

# Which month had the greatest average departure delay?
print(dep_delay_by_month %>% 
        filter(avg_dep_delay == max(avg_dep_delay)) %>% 
        select(month))

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
plot(dep_delay_by_month)

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
avg_arrival_delay <- flights %>% 
  group_by(dest) %>% 
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  arrange(-avg_arr_delay)
print(head(avg_arrival_delay, 3))
# You can look up these airports in the `airports` data frame!


# Which city was flown to with the highest average speed?
highest_avg_speed <- flights %>% 
  group_by(dest) %>% 
  summarize(avg_distance = mean(distance, na.rm = TRUE), avg_hour = mean(hour, na.rm = TRUE), avg_minute = mean(minute, na.rm = TRUE)) %>% 
  mutate(avg_time = avg_hour + avg_minute) %>% 
  mutate(avg_speed = avg_distance / avg_time) %>% 
  select(dest, avg_speed) %>% 
  filter(avg_speed == max(avg_speed))
print(highest_avg_speed)
