# for the distributions
# d stands for density, p stands for cdf, q(cdf) finds the value x with cdf,
# r stands for generating random variable following dist
rnorm(n = 10)
plot(density(rnorm(n=100000)))
dnorm(x = 0) # returns pdf
pnorm(q = 0) # returns cdf
qnorm(p = 0.975) # returns z score for type 1 error 0.05; qnorm(p = 0.5)  

# similar functions
# http://www.cyclismo.org/tutorial/R/probability.html
dt()
pt()
qt()
rt()

dchisq()
pchisq()
qchisq()
rchisq()

dlnorm()
plnorm()
qlnorm()
rlnorm()

# Back to our data
loan <- read.csv("loan.csv", stringsAsFactors = FALSE)
loanT <- loan

# understand t.test
# t.test(x, y = NULL, alternative = c("two.sided", "less", "greater"), 
# mu = 0, paired = FALSE, var.equal = FALSE, conf.level = 0.95, ...)
# Welch t-test (var.equal = FALSE) and student t-test(var.equal = TRUE)
t.test(int_rate ~ term, data = loan)

# How to calculate the stats by hand
short_term <- subset(loan, term == ' 36 months')
long_term <- subset(loan, term == ' 60 months')
stderr <- sqrt(var(short_term$int_rate) / dim(short_term)[1] +
                 var(long_term$int_rate) / dim(long_term)[1])
t.score <- (mean(short_term$int_rate) - mean(long_term$int_rate)) / stderr
# df follows complicated formula in slide (could be approximately in t.test).
p.val <- 2 * pt(t.score, df = 467040)

# understand chi-square test
# Check if grade has same distribution in short term and long term loans,
# what's null hypo and alternative hypo here?
round(with(loan, table(term, grade)) / as.numeric(table(loan$term)), 2)
with(loan, chisq.test(grade, term))
# p value
1 - pchisq(176070, df=6)

# if in chisq.test there is warning due to 0 cell, causing some expected values is < 5
# try fisher.test() 
# calculate the chi square stats
# expected value should be: 
apply(with(loan, table(term, grade)), 1, sum) # row sum
# 36 months  60 months 
#  621125     266254
apply(with(loan, table(term, grade)), 2, sum) # col sum
# A      B      C      D       E      F       G 
# 148202 254535 245860 139542  70705  23046   5489
observed <- with(loan, table(term, grade))
# expected value in cells should be:
num.grade <- apply(observed, 2, sum)
perc.term <- apply(observed, 1, sum)/dim(loan)[1]
expected <- rbind(num.grade * perc.term[1], num.grade * perc.term[2])
rownames(expected) <- c('short term', 'long term')
sum((observed - expected)^2/expected)

# First think about what features could be included in the model
# i.e., what features would be available during model building. Work example.
# e.g., loan payment features will not be available when deciding interest rate.

# Second think about what features should be included in the model
# i.e., Remove features using intuition, Remove features with unique value per row or no variance. 
#       Remove redundant features
# e.g., id, member.id

num.value <- sapply(loan, function(x){return(length(unique(x)))})
which(num.value == 1)
which(num.value == dim(loan)[1])

#loan$verification_status <- ifelse(loan$verification_status_joint != "",
#                                   loan$verification_status_joint, loan$verification_status)
summary(loan$dti_joint)
with(subset(loan, is.na(dti_joint)), table(application_type))
loan$dti <- ifelse(!is.na(loan$dti_joint), loan$dti_joint, loan$dti)
loan$annual_inc <- ifelse(!is.na(loan$annual_inc_joint), loan$annual_inc_joint, loan$annual_inc)
loan$home_ownership <- ifelse(loan$home_ownership %in% c('ANY', 'NONE', 'OTHER'), 'OTHER',
                              loan$home_ownership)
int_state <- by(loan, loan$addr_state, function(x) {
  return(mean(x$int_rate))
})
loan$state_mean_int <-
  ifelse(loan$addr_state %in% names(int_state)[which(int_state <= quantile(int_state, 0.25))], 
         'low', ifelse(loan$addr_state %in% names(int_state)[which(int_state <= quantile(int_state, 0.5))],
                       'lowmedium', ifelse(loan$addr_state %in% names(int_state)[which(int_state <= quantile(int_state, 0.75))], 
                                           'mediumhigh', 'high')))

num.NA <- sort(sapply(loan, function(x) { sum(is.na(x))} ), decreasing = TRUE)
remain.col <- names(num.NA)[which(num.NA <= 0.8 * dim(loan)[1])]
loan <- loan[, remain.col]

library(zoo)
loan$issue_d_1 <- as.Date(as.yearmon(loan$issue_d, "%b-%Y"))
loan$issue_year <- as.character(format(loan$issue_d_1, "%Y"))
loan$issue_mon <- as.character(format(loan$issue_d_1, "%m"))
int.by.year <- by(loan, loan$issue_year, function(x){return(mean(x$int_rate))})
plot(int.by.year)
int.by.mon <- by(loan, loan$issue_mon, function(x){return(mean(x$int_rate))})
plot(int.by.mon)

# split data into train and test for model performance
set.seed(1)
train.ind <- sample(1:dim(loan)[1], 0.7 * dim(loan)[1])
train <- loan[train.ind, ]
test <- loan[-train.ind, ]

mod1 <- lm(int_rate ~ addr_state + home_ownership + annual_inc + dti +
             + term + loan_amnt + total_acc + tot_cur_bal + open_acc,
           data = train)
summary(mod1)

mod2 <- lm(int_rate ~ state_mean_int + home_ownership + annual_inc + dti +
             + term + loan_amnt + total_acc + tot_cur_bal + open_acc,
           data = train)
summary(mod2)

train.sub <- train[, c('int_rate', 'state_mean_int', 'home_ownership', 'annual_inc', 'dti',
                       'term', 'loan_amnt', 'total_acc', 'tot_cur_bal', 'open_acc')]
dim(train.sub)
num.NA <- sort(sapply(train.sub, function(x) { sum(is.na(x))} ), decreasing = TRUE)
train.sub$tot_cur_bal[which(is.na(train.sub$tot_cur_bal))] <- median(train.sub$tot_cur_bal, na.rm = T)
train.sub$total_acc[which(is.na(train.sub$total_acc))] <- median(train.sub$total_acc, na.rm = T)
train.sub$open_acc[which(is.na(train.sub$open_acc))] <- median(train.sub$open_acc, na.rm = T)
train.sub$annual_inc[which(is.na(train.sub$annual_inc))] <- median(train.sub$annual_inc, na.rm = T)
mod2 <- lm(int_rate ~ ., data = train.sub)
summary(mod2)
# If seeing NA in coefficient, it means almost perfect correlation between features
alias(mod1)

# See extremely small estimate, e.g., loan_amnt, because of the magnitude, to compare the relative importance of features
# Standardize
train.sub.scale <- train.sub
train.sub.scale[, c(4,5,7,8,9,10)] <- scale(train.sub.scale[, c(4,5,7,8,9,10)])

mod3 <- lm(int_rate ~ ., data = as.data.frame(train.sub.scale))
# standardizing won't change the significant of features, but the estimate will change.

# Rows with any NA will be removed.
train.sub.matrix <- model.matrix( ~., train.sub)
head(train.sub.matrix)

x <- train.sub.matrix[, -2]
y <- train.sub.matrix[, 2]
# to calculate the XT*X
t(x) %*% x
# If there is error, due to only taking matrix as argument
# x <- as.matrix(x)

# note that X dim is n * (p+1), XT*X dim is (p+1) * (p+1)
# inverse
xtxi <- solve(t(x) %*% x)
# beta estimator
xtxi %*% t(x) %*% y
# compare with model fitted coefficient
coef(mod2)