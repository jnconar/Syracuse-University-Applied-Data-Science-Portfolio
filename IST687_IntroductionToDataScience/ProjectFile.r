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

PhoneService <- tapply(testFrame$customerID, list(testFrame$PhoneService,testFrame$Churn), length)
tapply(testFrame$customerID, list(testFrame$MultipleLines,testFrame$Churn), length)
tapply(testFrame$customerID, list(testFrame$InternetService,testFrame$Churn), length)
tapply(testFrame$customerID, list(testFrame$OnlineSecurity,testFrame$Churn), length)
tapply(testFrame$customerID, list(testFrame$OnlineBackup,testFrame$Churn), length)
tapply(testFrame$customerID, list(testFrame$TechSupport,testFrame$Churn), length)
tapply(testFrame$customerID, list(testFrame$StreamingTV,testFrame$Churn), length)
tapply(testFrame$customerID, list(testFrame$StreamingMovies,testFrame$Churn), length)


install.packages("ggplot2")
library(ggplot2)

# Need to create some DFs to plot
summary.phoneservice <- data.frame(
  phoneservice=levels(as.factor(testFrame$PhoneService)),
  PhoneService <- tapply(testFrame$customerID, list(testFrame$PhoneService,testFrame$Churn), length))

summary.phoneservice