# UNDERSTANDING WHY PEOPLE VOTE

# PROBLEM 1.1 - EXPLORATION AND LOGISTIC REGRESSION
gerber <- read.csv("./gerber.csv")
str(gerber)
table(gerber$voting)
table(gerber$voting)[[2]]
sum(table(gerber$voting))

table(gerber$voting)[[2]] / sum(table(gerber$voting))



# PROBLEM 1.2 - EXPLORATION AND LOGISTIC REGRESSION
str(gerber)
table(gerber$voting, gerber$civicduty)

table(gerber$voting, gerber$civicduty)[1,2]
table(gerber$voting, gerber$civicduty)[2,2]

# Civic Duty fraction: 0.3145377
table(gerber$voting, gerber$civicduty)[2,2] / (
	table(gerber$voting, gerber$civicduty)[1,2] + 
	table(gerber$voting, gerber$civicduty)[2,2]
	)
# Hawthorne Effect: 0.3223746
table(gerber$voting, gerber$hawthorne)[2,2] / (
	table(gerber$voting, gerber$hawthorne)[1,2] + 
	table(gerber$voting, gerber$hawthorne)[2,2]
	)
# Self: 0.3451515
table(gerber$voting, gerber$self)[2,2] / (
	table(gerber$voting, gerber$self)[1,2] + 
	table(gerber$voting, gerber$self)[2,2]
	)
# Neighbors: 0.3779482
table(gerber$voting, gerber$neighbors)[2,2] / (
	table(gerber$voting, gerber$neighbors)[1,2] + 
	table(gerber$voting, gerber$neighbors)[2,2]
	)


# PROBLEM 1.3 - EXPLORATION AND LOGISTIC REGRESSION
str(gerber)
m1 <- glm(voting ~ hawthorne + civicduty + 
				neighbors + self, 
				data = gerber, family = "binomial")
summary(m1)

# PROBLEM 1.4 - EXPLORATION AND LOGISTIC REGRESSION
pred <- predict(m1, type = "response")
str(pred)
table(gerber$voting, pred > 0.3)
t <- table(gerber$voting, pred > 0.3)

(t[1, 1] + t[2, 2]) / sum(t)

# PROBLEM 1.5 - EXPLORATION AND LOGISTIC REGRESSION
table(gerber$voting, pred > 0.5)
t <- table(gerber$voting, pred > 0.5)

t[1, 1] / sum(t)

# PROBLEM 1.6 - EXPLORATION AND LOGISTIC REGRESSION
library(ROCR)
ROCRpred = prediction(pred, gerber$voting)
as.numeric(performance(ROCRpred, "auc")@y.values)

# PROBLEM 2.1 - TREES
library(rpart)
library(rpart.plot)

CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber)
prp(CARTmodel)

# PROBLEM 2.2 - TREES
CARTmodel2 = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, cp=0.0)
prp(CARTmodel2)

# PROBLEM 2.3 - TREES
# 0.31

# PROBLEM 2.4 - TREES
CARTmodel3 = rpart(voting ~ sex + civicduty + hawthorne + self + neighbors, data=gerber, cp=0.0)
prp(CARTmodel3)
# 0
# 0

# PROBLEM 3.1 - INTERACTION TERMS
CARTmodel4 = rpart(voting ~ control, data=gerber, cp=0.0)
CARTmodel5 = rpart(voting ~ control + sex, data=gerber, cp=0.0)
prp(CARTmodel4, digits = 6)
abs(0.296638 - 0.34)


# PROBLEM 3.2 - INTERACTION TERMS
prp(CARTmodel5, digits = 6)

# female: 0.3342 - 0.2905
# male: 0.3458 - 0.3028
# 3

# PROBLEM 3.3 - INTERACTION TERMS
m2 <- glm(voting ~ sex + control, 
				data = gerber, family = "binomial")
summary(m2)
# 1

# PROBLEM 3.4 - INTERACTION TERMS
Possibilities = data.frame(sex=c(0,0,1,1),control=c(0,1,0,1))
predict(m2, newdata=Possibilities, type="response")
# Woman, Control - 0.2908065

prp(CARTmodel5, digits = 6)
# 0.290456
abs(0.2908065 - 0.290456)

# PROBLEM 3.5 - INTERACTION TERMS
LogModel2 = glm(voting ~ sex + control + sex:control, data=gerber, family="binomial")
summary(LogModel2)
# sex:control coeff is -0.007259, when sex = 1 and control = 1


# PROBLEM 3.6 - INTERACTION TERMS
predict(LogModel2, newdata=Possibilities, type="response")
abs(0.2904558 - 0.290456)
# 0.00000

# PROBLEM 3.7 - INTERACTION TERMS  
# NO: two many if we include every interaction

