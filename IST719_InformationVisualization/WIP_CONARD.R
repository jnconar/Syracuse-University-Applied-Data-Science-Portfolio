#########################################################
#
# Author: Jake Conard
# Purpose: Work In Progess (FINAL PROJECT)
# IST 719
#
#########################################################

fname <- file.choose()
nba <- read.csv(file = fname, header = TRUE, stringsAsFactors = FALSE)
str(nba)
View(nba)

# Team by Rating

df.team <- aggregate(nba$rating, list(team = nba$team), sum)
df.team
colnames(df.team)[2] <- "Combined_Rating"

df.team
df.team <- df.team[-1,]
df.team

rank <- ifelse(df.team$Combined_Rating > 1400, "Excellent", "Average")

rank[df.team$Combined_Rating < 1000 ] <- "Horrible"

ggplot(df.team) + aes(x = Combined_Rating, y = team, color = rank) +
  geom_point(aes(size = Combined_Rating)) +
  xlim(730, 1600) +
  theme_minimal() +
  ggtitle("NBA2K Combined Ranking by Team")


####################################################
#
# Ratings by Country
#
####################################################

library(rworldmap)
library(plotrix)

df.country <- aggregate(nba$rating, list(country = nba$country), sum)
df.country
colnames(df.country)[2] <- "Combined_Rating"

df.country

range(df.country$Combined_Rating)

num.cat <- 50

iso3.codes <- tapply(df.country$country
                     , 1:length(df.country$country)
                     , rwmGetISO3)

iso3.codes

df.country.new <- data.frame(country = iso3.codes, labels = df.country$country
                 , rating = df.country$Combined_Rating)

df.country.new

df.map <- joinCountryData2Map(df.country.new, joinCode = "ISO3"
                              , nameJoinColumn = "country")

par(mar = c(0,0,1,0))

mapCountryData(df.map
               , nameColumnToPlot = "rating"
               , numCats = num.cat
               , catMethod = 
                 c("pretty", "categorical", "diverging", "quantiles", "logFixedWidth")[5]
               , colourPalette = colorRampPalette(
                 c("orangered", "palegoldenrod", "forestgreen")
               )(num.cat)
               , oceanCol = "royalblue4"
               , borderCol = "peachpuff4"
               , mapTitle = "NBA2K Rating by Country")


################# Position by Rating

df.pos <- aggregate(nba$rating, list(position = nba$position), sum)
df.pos
colnames(df.pos)[2] <- "Combined_Rating"

df.pos

rank <- ifelse(df.pos$Combined_Rating > 1400, "Excellent", "Average")

rank[df.pos$Combined_Rating < 1000 ] <- "Horrible"

ggplot(df.pos) + aes(x = Combined_Rating, y = position, color = rank) +
  geom_point(aes(size = Combined_Rating)) +
  theme_minimal() +
  ggtitle("NBA2K Combined Rating by Position")

########################## wordcloud for college

library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(tm)

df.college <- aggregate(nba$rating, list(college = nba$college), sum)
df.college
colnames(df.college)[2] <- "Combined_Rating"
df.college <- df.college[-1,]
df.college

wordcloud(words = df.college$college
          , freq = df.college$Combined_Rating
          , scale=c(5,0.5)     # Set min and max scale
          , max.words=100      # Set top n words
          , random.order=FALSE # Words in decreasing freq
          , rot.per=0.35       # % of vertical words
          , use.r.layout=FALSE # Use C++ collision detection
          , colors=brewer.pal(8, "Dark2"))

###################### Hist for Draft Class

# By Draft Class

ggplot(nba) +
  aes(x = rating, y = draft_round) +
  geom_boxplot(color = "black", fill = 'orange') +
  ggtitle("NBA2k Rating by Draft Class")

########################### Hist of ratings disposition

hist(nba$rating
        , col = "orange"
        , main = "Distribution of NBA 2K20 Player Ratings"
        , xlab = "NBA2k20 Player Rating")
