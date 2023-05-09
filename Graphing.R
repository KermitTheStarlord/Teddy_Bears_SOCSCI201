## Graphing data from the Teddy Bears Dataset

#We're using the tidyverse package & ggplot
library(tidyverse)
library(ggplot2)
library(folio)

# Importing the CSV file
DataBase <- read.csv("DataBase.csv",sep=";",header=TRUE)

# We specify the number of bears
n_bears <- 121

# 1. Plotting ratio 1
# Selecting relevant data

# We itemize the bears
id <- c(1:n_bears)
# We extract their manufacturing year
Year <- DataBase$Year
# We take the mean of both measurement of ratio 1
MeanRatio1 <- rowMeans(DataBase[,c('M1_ratio_1', 'M2_ratio_1')], na.rm=TRUE)
# We fuse these vectors
firstRatio <- data.frame(id=id, year=Year, ratio_1=MeanRatio1)

# We plot the evolution of ratio 1
ggplot(data = firstRatio, aes(x = Year, y = MeanRatio1)) +
  geom_point() +
  theme_bw() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  xlab("Manufacturing year") +
  ylab("Ratio of eyes to crown by eyes to base of head")

# 2. Plotting ratio 2
# Selecting relevant data

# We itemize the bears
id <- c(1:n_bears)
# We extract their manufacturing year
Year <- DataBase$Year
# We take the mean of both measurement of ratio 1
MeanRatio2 <- rowMeans(DataBase[,c('M1_ratio_2', 'M2_ratio_2')], na.rm=TRUE)
# We remove the 0 obtained from missing data points
MeanRatio2[MeanRatio2==0] <- NA
# We fuse these vectors
secondRatio <- data.frame(id=id, Year=Year, ratio_2=MeanRatio2)
secondRatio <- na.omit(secondRatio)

# We plot the evolution of ratio 2
ggplot(data = secondRatio, aes(x = Year, y = ratio_2)) +
  geom_point() +
  theme_bw() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  xlab("Manufacturing year") +
  ylab("Ratio of tip of snoot to back of head by top of head to base")
