loan <- read.csv("loan.csv", stringsAsFactors = FALSE)
loanT <- loan

loan$dti <- ifelse(!is.na(loan$dti_joint), loan$dti_joint, loan$dti)
loan$annual_inc <- ifelse(!is.na(loan$annual_inc_joint), loan$annual_inc_joint, loan$annual_inc)
num.NA <- sort(sapply(loan, function(x) {sum(is.na(x))}), decreasing=TRUE)
remain.col <- names(num.NA)[which(num.NA <= 0.8 * dim(loan)[1])]
loan <- loan[, remain.col]
loan$home_ownership <- ifelse(loan$home_ownership %in% c('ANY', 'NONE', 'OTHER'), 'OTHER',
                              loan$home_ownership)
int_state <- by(loan, loan$addr_state, function(x) {
  return(mean(x$int_rate))
})
loan$state_mean_int <-
  ifelse(loan$addr_state %in% names(int_state)[which(int_state <=
                                                       quantile(int_state, 0.25))], 'low',
         ifelse(loan$addr_state %in% names(int_state)[which(int_state <=
                                                              quantile(int_state, 0.5))],'lowmedium',
                ifelse(loan$addr_state %in% names(int_state)[which(int_state <= quantile(int_state, 0.75))], 
                       'mediumhigh', 'high')))
loan$tot_cur_bal[which(is.na(loan$tot_cur_bal))] <- median(loan$tot_cur_bal, na.rm = T)
loan$total_acc[which(is.na(loan$total_acc))] <- median(loan$total_acc, na.rm = T)
loan$open_acc[which(is.na(loan$open_acc))] <- median(loan$open_acc, na.rm = T)
loan$annual_inc[which(is.na(loan$annual_inc))] <- median(loan$annual_inc, na.rm = T)
# Build model and evaluate performance
# split data into train and test for model performance
set.seed(1)
train.ind <- sample(1:dim(loan)[1], 0.7 * dim(loan)[1])
train <- loan[train.ind, ]
test <- loan[-train.ind, ]
train.sub <- train[, c('int_rate', 'state_mean_int', 'home_ownership', 'annual_inc', 'dti',
                       'term', 'loan_amnt', 'total_acc', 'tot_cur_bal', 'open_acc')]
mod2 <- lm(int_rate ~ ., data = train.sub)
summary(mod2)