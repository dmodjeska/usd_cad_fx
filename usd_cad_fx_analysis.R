
library(readr)
library(dplyr)
library(car)

set.seed(9883)

num_numeric_cols <- 35
col_types <- paste('c', paste(rep('n', num_numeric_cols), collapse = ""),
                   sep = "")
na_strings = c("", "ND", "#VALUE!", "#N/A")
data_read <- read_csv("DataSet_21Apr2016C.csv", na = na_strings,
                      col_types = col_types)

data0 <- data_read[ , 1:(num_numeric_cols + 1)]

for (i in 2:ncol(data0)) {
    for (j in 2:nrow(data0)) {
        if (is.na(data0[j, i]) | (data0[j, i] == 0)) {
            data0[j, i] <- data0[j-1, i]
        }
    }
}

sample_data <- sample_frac(data0, 0.1)
write_csv(data0, "data.csv")
cor(data0[, 2:ncol(data0)], method = "pearson", use = "pairwise.complete.obs")

# FIT MULTIPLE REGRESSION MODEL -----------------------------------------

# oil only
fitOil <- lm(FXRate ~ OilPrice, data = sample_data)
summary(fitOil)
plot(fitOil)

# oil + gold
fitOilGold <- lm(FXRate ~ OilPrice + GoldPrice , data = sample_data)
summary(fitOilGold)
plot(fitOilGold)
vif(fitOilGold)

# include any of oil futures predictors? Yes - Oil_Future_Open explains
# more variability than OilPrice, while being highly collinear
fitOilFutures <- lm((FXRate) ~ OilPrice + GoldPrice
                    + Oil_Future_Open + Oil_Future_High + Oil_Future_Low
                    + Oil_Future_Last + Oil_Future_Settle
                    + Oil_Future_Volume + Oil_Future_Open_Int,
                    data = sample_data)
num_diff_vars <- 7
df_error_full <- summary(fitOilFutures)$df[2]
SSE_reduced <- sum(fitOilGold$residuals^2)
SSE_full <- sum(fitOilFutures$residuals^2)
F_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(F_value, num_diff_vars, df_error_full, lower.tail = FALSE)

fitOilGold2 <- lm(FXRate ~ Oil_Future_Open + GoldPrice , data = sample_data)
summary(fitOilGold2)
plot(fitOilGold2)
vif(fitOilGold2)

fitOilGold2 <- lm(FXRate ~ Oil_Future_Open + GoldPrice , data = sample_data)
summary(fitOilGold2)
plot(fitOilGold2)
vif(fitOilGold2)

# include any of GDP predictors? Yes - CA_GDP adds approx. 10% to adjusted RSq
fitGDP <- lm((FXRate) ~ Oil_Future_Open + GoldPrice
             + GDP_CA + GDPOilAndGas + GDP_US
             + CA_GDP_Growth + US_GDP_Growth,
             data = sample_data)
num_diff_vars <- 5
df_error_full <- summary(fitGDP)$df[2]
SSE_reduced <- sum(fitOilGold2$residuals^2)
SSE_full <- sum(fitGDP$residuals^2)
F_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(F_value, num_diff_vars, df_error_full, lower.tail = FALSE)

fitOilGold2GDP <- lm(FXRate ~ Oil_Future_Open + GoldPrice + GDP_CA , data = sample_data)
summary(fitOilGold2GDP)
plot(fitOilGold2GDP)
vif(fitOilGold2GDP)

# include any of currency predictors? Nested F-test OK, but VIF bad
fitCurrency <- lm((FXRate) ~ Oil_Future_Open + GoldPrice + GDP_CA
                  + FX_USD_Per_GBP + FX_USD_Per_EUR + FX_USD_Per_SEK
                  + FX_USD_Per_JPY + FX_USD_Per_CHF + FX_USD_Per_Basket,
                  data = sample_data)
num_diff_vars <- 6
df_error_full <- summary(fitCurrency)$df[2]
SSE_reduced <- sum(fitOilGold2GDP$residuals^2)
SSE_full <- sum(fitCurrency$residuals^2)
F_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(F_value, num_diff_vars, df_error_full, lower.tail = FALSE)
vif(fitCurrency)

# include any of interest predictors? Nested F-test OK, group VIF bad,
# individual VIF OK, but any individual adds than 1% adjusted RSq,
# so parsimony argues for omitting these predictors
fitInterest <- lm((FXRate) ~ Oil_Future_Open + GoldPrice + GDP_CA
             + CADInterestON + CADInterest3M + USDInterestON + USDInterest3M,
             data = sample_data)
num_diff_vars <- 4
df_error_full <- summary(fitInterest)$df[2]
SSE_reduced <- sum(fitOilGold2GDP$residuals^2)
SSE_full <- sum(fitInterest$residuals^2)
F_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(F_value, num_diff_vars, df_error_full, lower.tail = FALSE)
vif(fitInterest)

# include any of resource predictors? Nested F-test OK, but IronOre VIF bad
fitResource <- lm((FXRate) ~ Oil_Future_Open + GoldPrice + GDP_CA
                  + IronOre,
                  data = sample_data)
num_diff_vars <- 1
df_error_full <- summary(fitResource)$df[2]
SSE_reduced <- sum(fitOilGold2GDP$residuals^2)
SSE_full <- sum(fitResource$residuals^2)
F_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(F_value, num_diff_vars, df_error_full, lower.tail = FALSE)
vif(fitResource)

# include any of second-order predictors? Yes - Oil_Future_Open
fitQuadratic <- lm((FXRate) ~ Oil_Future_Open + GoldPrice + GDP_CA
                  + I(Oil_Future_Open ^ 2) + I(GoldPrice ^ 2) + I(GDP_CA ^ 2),
                  data = sample_data)
num_diff_vars <- 3
df_error_full <- summary(fitQuadratic)$df[2]
SSE_reduced <- sum(fitOilGold2GDP$residuals^2)
SSE_full <- sum(fitQuadratic$residuals^2)
F_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(F_value, num_diff_vars, df_error_full, lower.tail = FALSE)

# FINAL MODEL -----------------

fitFinal <- lm(FXRate ~ Oil_Future_Open + I(Oil_Future_Open ^ 2) + GoldPrice
               + GDP_CA,
               data = sample_data)
summary(fitFinal)
plot(fitFinal)
vif(fitFinal)

# include any of interaction predictors? Nested F-test OK,
# but only interactions with first-order terms are with GoldPrice,
# and gains in ARsq are less than 1% and violate residual normality
fitInteraction <- lm((FXRate) ~  Oil_Future_Open * I(Oil_Future_Open ^ 2) * GoldPrice
                   * GDP_CA,
                   data = sample_data)
num_diff_vars <- 6
df_error_full <- summary(fitInteraction)$df[2]
SSE_reduced <- sum(fitFinal$residuals^2)
SSE_full <- sum(fitInteraction$residuals^2)
F_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(F_value, num_diff_vars, df_error_full, lower.tail = FALSE)

# NESTED F-TESTS ------------------------------------------

# oil futures
fitOilFutures <- lm((FXRate) ~ poly(OilPrice, 2) + GoldPrice + GDP_CA
                  + Oil_Future_Open + Oil_Future_High + Oil_Future_Low
                  + Oil_Future_Last + Oil_Future_Settle
                  + Oil_Future_Volume + Oil_Future_Open_Int,
                  data = data0)
num_diff_vars <- 7
df_error_full <- summary(fitOilFutures)$df[2]
SSE_reduced <- sum(fitMultiSimple$residuals^2)
SSE_full <- sum(fitOilFutures$residuals^2)
f_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(f_value, num_diff_vars, df_error_full, lower.tail = FALSE)

# currency terms (but note VIF)
fitCurrencies <- lm((FXRate) ~ poly(Oil_Future_Open, 2) + GoldPrice + GDP_CA
                    + FX_USD_Per_GBP + FX_USD_Per_EUR + FX_USD_Per_JPY
                    + FX_USD_Per_CHF + FX_USD_Per_SEK,
                    data = data0)
summary(fitCurrencies)
num_diff_vars <- 5
df_error_full <- summary(fitCurrencies)$df[2]
SSE_reduced <- sum(fitMultiSimple$residuals^2)
SSE_full <- sum(fitCurrencies$residuals^2)
f_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(f_value, num_diff_vars, df_error_full, lower.tail = FALSE)

# CAD futures terms (but note VIF and logic)
fitCADFuture <- lm((FXRate) ~ poly(Oil_Future_Open, 2) + GoldPrice + GDP_CA
                    + CAD_Future_Open + CAD_Future_High + CAD_Future_Low
                   + CAD_Future_Last + CAD_Future_Change + CAD_Future_Settle
                   + CAD_Future_Volume + CAD_Future_Open_Int,
                    data = data0)
summary(fitCADFuture)
num_diff_vars <- 8
df_error_full <- summary(fitCADFuture)$df[2]
SSE_reduced <- sum(fitMultiSimple$residuals^2)
SSE_full <- sum(fitCADFuture$residuals^2)
f_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(f_value, num_diff_vars, df_error_full, lower.tail = FALSE)

# quadratic terms
fitMultiSimplePoly1 <- lm((FXRate) ~ poly(Oil_Future_Open, 1) + GoldPrice + GDP_CA,
                     data = data0)
num_diff_vars <- 2
df_error_full <- summary(fitMultiSimplePoly1)$df[2]
SSE_reduced <- sum(fitMultiSimplePoly1$residuals^2)
SSE_full <- sum(fitMultiSimple$residuals^2)
f_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(f_value, num_diff_vars, df_error_full, lower.tail = FALSE)

# iron and coal
fitIronCoal <- lm((FXRate) ~ poly(Oil_Future_Open, 2) + GoldPrice + GDP_CA
                  + IronOre + Coal,
                  data = data0)
num_diff_vars <- 2
df_error_full <- summary(fitIronCoal)$df[2]
SSE_reduced <- sum(fitMultiSimple$residuals^2)
SSE_full <- sum(fitIronCoal$residuals^2)
f_value <- ((SSE_reduced - SSE_full) / num_diff_vars) /
    (SSE_full / df_error_full)
p_value <- pf(f_value, num_diff_vars, df_error_full, lower.tail = FALSE)

# Bootstrap 95% CI for R-Squared --------------------------------

library(boot)

# clean data
data_boot <- data0 %>%
    filter(!is.na(FXRate) & !is.na(Oil_Future_Open) & !is.na(GoldPrice)
           & !is.na(GDP_CA))

# function to obtain adjusted R-Squared from the data
Adjusted_R_Sq <- function(formula, data, indices) {
    d <- data[indices,] # allows boot to select sample
    fit <- lm(formula, data = d)
    return(summary(fit)$adj.r.square)
}

# bootstrapping with 1000 replications
boot_results <- boot(data = data0, statistic = Adjusted_R_Sq,
                R = 1000, formula = FXRate ~ poly(Oil_Future_Open, 2)
                + GoldPrice + GDP_CA, stype = "i")
boot_results
plot(boot_results)

# get 95% confidence interval
boot.ci(boot_results, type="bca")


# RANDOM FORESTS -------------------------------------

library(caret)
library(AppliedPredictiveModeling)

train_measures <- data0 %>%
    dplyr::select(-Date, -FXRate)

# repeated k-fold cross-validation
train_ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 10)
mod_fit_rf <- train(data0$FXRate ~ ., method = "rf", preProcess = c("center", "scale"),
                    data = train_measures, trControl = train_ctrl)
mod_fit_rf
# plot(varImp(mod_fit_rf), main = "Variable Importance in Random Forest Model")


