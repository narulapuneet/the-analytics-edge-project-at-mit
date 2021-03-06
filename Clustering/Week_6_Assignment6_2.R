# MARKET SEGMENTATION FOR AIRLINES

rm(list = ls())
airlines <- read.csv("AirlinesCluster.csv")
# PROBLEM 1.1 - NORMALIZING THE DATA
summary(airlines)

# PROBLEM 1.2 - NORMALIZING THE DATA

# PROBLEM 1.3 - NORMALIZING THE DATA
#install.packages("caret")
library(caret)
preproc = preProcess(airlines)

airlinesNorm = predict(preproc, airlines)
summary(airlinesNorm)
#sd(airlinesNorm)

# PROBLEM 2.1 - HIERARCHICAL CLUSTERING  
# Compute distances
distance = dist(as.vector(airlinesNorm), method = "euclidean")
# Hierarchical clustering
clusterIntensity = hclust(distance, method="ward.D")
# Plot the dendrogram
plot(clusterIntensity)

# PROBLEM 2.2 - HIERARCHICAL CLUSTERING
airlinesClusters = cutree(clusterIntensity, k = 5)
sum(airlinesClusters == 1)

# PROBLEM 2.3 - 2.7 HIERARCHICAL CLUSTERING
str(airlines)
tapply(airlines$Balance, airlinesClusters, mean)
tapply(airlines$QualMiles, airlinesClusters, mean)
tapply(airlines$BonusMiles, airlinesClusters, mean)
tapply(airlines$BonusTrans, airlinesClusters, mean)
tapply(airlines$FlightMiles, airlinesClusters, mean)
tapply(airlines$FlightTrans, airlinesClusters, mean)
tapply(airlines$DaysSinceEnroll, airlinesClusters, mean)

# PROBLEM 3.1 - K-MEANS CLUSTERING
set.seed(88)
KMC = kmeans(as.vector(airlinesNorm), centers = 5, iter.max = 1000)
str(KMC)
table(KMC$cluster)

# PROBLEM 3.2 - K-MEANS CLUSTERING
tapply(airlines$Balance, KMC$cluster, mean)
tapply(airlines$QualMiles, KMC$cluster, mean)
tapply(airlines$BonusMiles, KMC$cluster, mean)
tapply(airlines$BonusTrans, KMC$cluster, mean)
tapply(airlines$FlightMiles, KMC$cluster, mean)
tapply(airlines$FlightTrans, KMC$cluster, mean)
tapply(airlines$DaysSinceEnroll, KMC$cluster, mean)

