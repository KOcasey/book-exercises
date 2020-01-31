# Exercise 2: working with `dplyr`
# Note that this exercise repeats the analysis from Exercise 1, but should be 
# performed using `dplyr` (do not directly access or manipulate the data frames)

# Install and load the "fueleconomy" package
#install.packages("devtools")
#devtools::install_github("hadley/fueleconomy")
library(fueleconomy)

# Install and load the "dplyr" library
library(dplyr)

# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable
manufacturers <- select(vehicles, "make")

# Use the `distinct()` function to determine how many different car manufacturers
# are represented by the data set
distinct(manufacturers)

# Filter the data set for vehicles manufactured in 1997
x1997_cars <- filter(vehicles, year == "1997")

# Arrange the 1997 cars by highway (`hwy`) gas milage
x1997_cars <- arrange(x1997_cars, hwy)

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
x1997_cars <- mutate(x1997_cars, average = (x1997_cars$hwy + x1997_cars$cty) / 2)

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
more_than_20_mpg_cty <- filter(vehicles, drive == "2-Wheel Drive", cty > 20)

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
select(filter(more_than_20_mpg_cty, hwy == min(hwy)), "id")

# Write a function that takes a `year_choice` and a `make_choice` as parameters,
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
most_efficient <- function(year_choice, make_choice){
  make_and_year <- filter(vehicles, year == "1995", make == "Honda") 
  best_hwy <- filter(make_and_year, hwy == max(hwy))
  return(best_hwy$model)
}

# What was the most efficient Honda model of 1995?
most_efficient("1995", "Honda")
