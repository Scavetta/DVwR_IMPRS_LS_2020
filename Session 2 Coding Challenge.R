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

# Exercises:
# 1 - Need to deal with overplotting - 3 different ways to implement the solution
# 2 - Change shape

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

# Additional exercises ----
# 3 - Add linear models, without background
# 4 - Re-position the legend to the upper left corner
# 5 - Change the colors - use Dark2 from color brewer
# 6 - Remove non-data ink
# 7 - Relabel the axes, add a title or caption
# 8 - Change the aspect ratio
# 9 - Set limits on the x and y axes
# 10 - Extra, remove color and use facets instead
g +
  geom_point(position = posn_j, alpha = 0.65, shape = 1) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_brewer(palette =  "Dark2") +
  labs(x = "Length (cm)", y = "Width (cm)", color = "Species",
       title = "The iris dataset", caption = "Anderson, 1931") +
  coord_fixed(1, expand = 0, xlim = c(4, 8), ylim = c(2,4)) +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = c(0.1, 0.85))

# legend position is in units of npc

# Specifying which group gets which color:
myColors_named <- c(virginica = "#377EB8", 
                    setosa = "#4DAF4A", 
                    versicolor = "#984EA3")

g +
  geom_point(position = posn_j, alpha = 0.65, shape = 1) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_manual(values = myColors_named)

# Manually set breaks:
# scale_x_continuous("Length (cm)", 
#                    limits = c(4, 8), 
#                    breaks = seq(4, 8, 0.5),
#                    expand = c(0,0)) +
  
# Automatically labelling points on a plot
library(MASS)
# USe this data:
mammals
# NAmes must be a variable in the data frame
mammals$name <- row.names(mammals)

# It's best if the points to be labelled are already identified in the data:
mammals$interesting <- mammals$brain > 2000

ggplot(mammals, aes(body, brain, label = name)) +
  geom_point(alpha = 0.5, shape = 16) +
  geom_text(data = mammals[mammals$interesting,])

# ggrepel to reposition the labels
library(ggrepel)
ggplot(mammals, aes(body, brain, label = name)) +
  geom_point(alpha = 0.5, shape = 16) +
  geom_text_repel(data = mammals[mammals$interesting,])


