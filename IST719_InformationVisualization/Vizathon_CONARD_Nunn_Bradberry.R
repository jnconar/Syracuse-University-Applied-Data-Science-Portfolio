#########################################################
#
# Author: Jake Conard
# Purpose: Vizathon
# BuoyData
# IST 719
#
#########################################################

library(tidyverse)
library(readxl)
library(ggplot2)
library(lubridate)

my_data <- read_excel(file.choose(), sheet = "2016-2018 data")
my_data
View(my_data)

head(my_data)

str(my_data)

tail(my_data)

dim(my_data)

colnames(my_data)

# Date and Degree Color by Depth

ggplot(data = my_data, aes(x = DATE_TIME, y = T_DEGC)) +
  geom_point(color = "red") +
  theme_minimal() +
  theme(text=element_text(color="white"),axis.text=element_text(color="white")) +
  labs(x = "Date",
       y = "Temperature in Degrees (Celsius)",
       title = "Onondage County Lake Water Quality Monitoring",
       subtitle = "Temperature in Degrees by Date")

# Hist of Temp in Cels

hist(my_data$T_DEGC, col = "red"
     , main = "Onondage County Lake Temperature Distribution"
     , xlab = "Temperature in Degrees (Celsius)"
     , col.axis = "white"
     , col.lab = "white"
     , col.main = "white")

# Hist of Acidity Levels

hist(my_data$pH, col = "orange"
     , main = "Onondage County Lake Acidity Distribution"
     , xlab = "pH Levels (Acidity)"
     , col.axis = "white"
     , col.lab = "white"
     , col.main = "white")

# Boxplot of Acidity Levels

ggplot(data = my_data, aes(x = month(DATE_TIME, label = TRUE), y = pH)) +
  geom_boxplot(color="black", fill="orange", alpha=0.7) +
  theme_minimal() +
  coord_flip() +
  theme(text=element_text(color="white"),axis.text=element_text(color="white")) +
  labs(x = "Date by Month",
       y = "Measure of Acidity",
       title = "Onondage County Lake Water Quality Monitoring",
       subtitle = "pH Levels by Month")



