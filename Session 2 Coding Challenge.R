# Coding exercises for Data Visualization
# Rick Scavetta
# 16.10.2020
# Notes from the second 2-hour group session

# Using color ----
# Colors can be defines using a hex code:
myRed <- "#e41a1c" # RRGGBB

# hexidecimal (base 16): 0-9,A-F 
# 1-digit: 16 (16^1)
# 2-digit: 256 (16^2) 00-FF


# Decimal (base 10): 0-9
# 1-digit: 10 (10^1)
# 2-digit: 100 (10^2) 00-99

256*256*256 # Red*Green*Blue = 16 777 216

# Get colors:
library(RColorBrewer)
myColors <- brewer.pal(4, "Set1")[2:4]

munsell::plot_hex(myColors)

# ggplot2 coding challenge ----

# Exercise 1:
# 1 - Need to deal with overplotting - 3 different ways to implement the solution
# 2 - Change shape
# 3 - Add linear models, without background
# 4 - Change the colors - use Dark2 from color brewer
# 5 - Re-position the legend
# 6 - Remove non-data ink
# 7 - Relabel the axes
# 8 - Change the aspect ratio
# 9 - Set limits on the x and y axes
# 10 - Extra, remove color and use facets instead

# load package
library(ggplot2)

# Use the iris dataset
iris
str(iris)
# Base layer,  sepal width (y) vs sepal length (x) and Species (color)
g <- ggplot(iris, aes(x = Sepal.Length, 
                      y = Sepal.Width, 
                      color = Species))

# Create basic scatter plot
# This it mostly perfectly fine, but it doesn't 
# guarantee there will be no overplotting, 
# so always consider if it's the right choice.
g +
  geom_point()

# Typically use position, here jitter
# 1 - Use the position argument
# Easy, most inflexible
g +
  geom_point(position = "jitter", alpha = 0.4)

# 2 - Use the geom_jitter()
# Convenient, inflexible
g +
  geom_jitter(alpha = 0.4)

# 3 - Use a position_*() function
# Most flexible and full-featured
posn_j <- position_jitter(seed = 136)
g +
  geom_point(position = posn_j, 
             alpha = 0.65, 
             shape = 1)

# Also use alpha and/or shape and/or size in combination

# low precision data, i.e.
# If both X and Y are integer
library(car)
ggplot(Vocab, aes(x = education, y = vocabulary)) +
  geom_point()

ggplot(Vocab, aes(x = education, y = vocabulary)) +
  geom_point(position = "jitter", alpha = 0.15, shape = ".")

# AESTHETIC - MAPPING a variable onto a SCALE
# ATTRIBUTE - SETTING how a geommetry looks



