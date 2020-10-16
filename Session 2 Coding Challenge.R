# Coding exercises for Data Visualization
# Rick Scavetta
# 15.06.2020
# Notes from the second 2-hour group session

# Using color ----
# Colors can be defined using a hex code: 
myRed <- "#e41a1c" # #RRGGBB

# hexidecimal (base 16): 0-9, A-F
# 1-digit numbers: 16 (16^1)
# 2-digit numbers: 256 (16^2)
# 00 - FF

# base 10:
# 1-digit numbers: 10 (10^1)
# 2-digit numbers: 100 (10^2)
# 00 - 99
256*256*256 # (Red*Blue*Green) 16 777 216 colors

# Get colors:
library(RColorBrewer)
myColors <- brewer.pal(4, "Set1")[2:4]

# view
munsell::plot_hex(myColors)

# ggplot2 ----

# Exercise 1:
# 1 - Need to deal with overplotting - 3 different ways to implement the solution
# 2 - Change shape
# 3 - Add models, without background
# 4 - Change the colors - use Dark2 from color brewer
# 5 - Re-position the legend
# 6 - Remove non-data ink
# 7 - Relabel the axes
# 8 - Change the aspect ratio
# 9 - Set limits on the x and y axes
# 10 - Extra, remove color and use facets instead

library(ggplot2)
g <- ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species))

# basic scatter plot:
# This it mostly perfectly fine, but it doesn't 
# guarantee there will be no overplotting, so always consider if it's the right choice.
g +
  geom_point()

# Even if the data doesn't suffer from overplotting, 
# e.g. if it wasn't low-precision data, like we have here,
# we probably want to change some of these arguments:
g +
  geom_point(shape = 16, alpha = 0.4)

# 1 - Use position argument  - full-featured & flexible
g +
  geom_point(position = position_jitter(seed = 136))

# This is flexible, since I can set the randomization seed once
# and have consistency in all later plots:
posn_j <- position_jitter(seed = 136)
g +
  geom_point(position = posn_j)

# 2 - easy, most inflexible
g +
  geom_point(position = "jitter")

# 3 - Using a geom_*() - convenient but not flexible:
g +
  geom_jitter(shape = 1)

# Our completed plot ----
# I'm using method 2 to be certain about the jittering, 
# but it's not necessary in all cases, you can also just use method 1 above or even none
g +
  # geom_point(shape = 16, alpha = 0.5) + # If appropriate
  geom_point(shape = 1, position = position_jitter(seed = 196)) + # If necessary
  geom_smooth(method = "lm", se = FALSE) +
  coord_fixed(1, xlim = c(4,8), ylim = c(2,5), expand = 0) +
  scale_color_brewer(palette = "Dark2") +
  labs(title = "The iris dataset", 
       subtitle = "Anderson, 1931", 
       caption = "Yes, again!",
       x = "Sepal Length (cm)", y = "Sepal Width (cm)", color = "") +
  theme_classic() +
  theme(text = element_text(family = "serif", face = "bold"),
        rect = element_blank(),
        # axis.line = element_blank(),
        legend.position = c(0.1, 0.9)) +
  NULL

# Some additional notes ----
# 1 - To remove buffer on edges of axes, you can also use:
# but note this will also FILTER OUT (i.e. remove) any data outside the limits
# so never copy and paste these commands to unseen plots
g +
  geom_point(shape = 16, alpha = 0.5) +
  scale_x_continuous(limits = c(4,8), expand = c(0,0))

# 2 - An alternative way for color changes is to manually specific color definitions
# 2a - As a character vector:
myColors <- c("#1b9e77", "#d95f02", "#7570b3")

# visualize them:
munsell::plot_hex(myColors)
# green orange purple

# This just applies each color to each level in the order they appear
# i.e.
levels(iris$Species)
# [1] "setosa"     "versicolor" "virginica" 
# will get green, orange, purple as above

# Our plot:
g +
  geom_point(shape = 16, alpha = 0.5) +
  scale_color_manual(values = myColors)

# 2b - Or as a named character vector:
myColors_named <- c(virginica = "#1b9e77", 
                    setosa = "#d95f02",
                    versicolor = "#7570b3")
myColors_named # how a named vector looks

# Using a named vector to define the exact color-level pairing you want
# This makes color choices consistent across all your plots!
g +
  geom_point(shape = 16, alpha = 0.5) +
  scale_color_manual(values = myColors_named)

# 3 - Default method for geom_smooth is loess 
g +
  geom_jitter(shape = 1) +
  geom_smooth(se = FALSE)