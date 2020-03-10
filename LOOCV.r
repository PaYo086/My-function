# Leave one out cross validation (multiple linear regression)
LOOCV <- function(res.v, exp.v){
  options(scipen = 999)
  # Root Mean Squard Error
  rmse <- function(obs, pre){
    return(sqrt(mean((pre - obs)^2)))
  }
  v <- cbind(res.v, exp.v)
  if (ncol(v) == 2){
    model.formula <- as.formula("res.v ~ exp.v") # colnames become these
    v <- as.data.frame(v) # turn matrix into data frame
  }else{
    model.formula <- as.formula(paste0("res.v ~ ", paste(colnames(exp.v), collapse = "+")))
  }
  predictions <- error <- vector("numeric", length = nrow(v))
  for (i in 1:nrow(v)) {
    model <- lm(model.formula, data = v[-i,])
    predictions[i] <- predict(model, v[i,])
    error[i] <- rmse(res.v[i], predictions[i])
  }
  result <- c(rmse(res.v, predictions), summary(lm(predictions ~ res.v))$r.squared, mean(error), sd(error))
  names(result) <- c("Global RMSE", "R squared", "Mean RMSE", "SD")
  return(result)
}
