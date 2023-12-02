# IST687 Group Project -- Telco Churn Dataset [Kaggle]
# https://www.kaggle.com/blastchar/telco-customer-churn
# Jake Conard

# I am looking at the effect on Churn based on the various
# services that a customer has on the Telco plan to include
# Phone
# Multiple Lines
# Internet
# Online Security
# Online Backup
# Device Protection
# Tech Support
# Streaming TV
# Streaming Movies

# Read in dataset from a .csv
testFrame <- read.csv("C:\\Users\\jncon\\OneDrive - Syracuse University\\Desktop\\Syracuse\\IST687\\Project\\project.csv.csv")

# Check the dataframe to ensure structure.
str(testFrame)

# Utilize the tapply function to transform the data to new dataframes
# this will help see the impact of each attribute for churn
# and help with the plotting. 

MultLineVchurn <- data.frame(tapply(testFrame$customerID, list(testFrame$MultipleLines,testFrame$Churn), length))
IntServiceVchurn <- data.frame(tapply(testFrame$customerID, list(testFrame$InternetService,testFrame$Churn), length))
OnlineSecVchurn <- data.frame(tapply(testFrame$customerID, list(testFrame$OnlineSecurity,testFrame$Churn), length))
OnlineBackVchurn <- data.frame(tapply(testFrame$customerID, list(testFrame$OnlineBackup,testFrame$Churn), length))
TechSupportVchurn <- data.frame(tapply(testFrame$customerID, list(testFrame$TechSupport,testFrame$Churn), length))
StreamingTV_Vchurn <- data.frame(tapply(testFrame$customerID, list(testFrame$StreamingTV,testFrame$Churn), length))
StreamingMovieVchurn <- data.frame(tapply(testFrame$customerID, list(testFrame$StreamingMovies,testFrame$Churn), length))

#Install the plotting packages

install.packages("ggplot2")
library(ggplot2)
library(dplyr)

# Create density plots to quickly identify the Churn visually in a 
# density plot for each of the attributes.

testFrame %>% ggplot(aes(x=InternetService,fill=Churn))+ geom_density(alpha=0.8)+scale_fill_manual(values=c('pink','purple'))+labs(title='Internet Service split churn vs non churn' )
testFrame %>% ggplot(aes(x=PhoneService,fill=Churn))+ geom_density(alpha=0.8)+scale_fill_manual(values=c('pink','purple'))+labs(title='Phone Service split churn vs non churn' )
testFrame %>% ggplot(aes(x=MultipleLines,fill=Churn))+ geom_density(alpha=0.8)+scale_fill_manual(values=c('pink','purple'))+labs(title='Multiple Lines split churn vs non churn' )
testFrame %>% ggplot(aes(x=OnlineSecurity,fill=Churn))+ geom_density(alpha=0.8)+scale_fill_manual(values=c('pink','purple'))+labs(title='Online Security split churn vs non churn' )
testFrame %>% ggplot(aes(x=DeviceProtection,fill=Churn))+ geom_density(alpha=0.8)+scale_fill_manual(values=c('pink','purple'))+labs(title='Device Protection split churn vs non churn' )
testFrame %>% ggplot(aes(x=TechSupport,fill=Churn))+ geom_density(alpha=0.8)+scale_fill_manual(values=c('pink','purple'))+labs(title='Tech Support split churn vs non churn' )
testFrame %>% ggplot(aes(x=StreamingTV,fill=Churn))+ geom_density(alpha=0.8)+scale_fill_manual(values=c('pink','purple'))+labs(title='Streaming TV split churn vs non churn' )
testFrame %>% ggplot(aes(x=StreamingMovies,fill=Churn))+ geom_density(alpha=0.8)+scale_fill_manual(values=c('pink','purple'))+labs(title='Streaming Movies split churn vs non churn' )
