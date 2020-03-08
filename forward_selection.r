forward.selection <- function(res.v, exp.v, test.p = 0.05, p.adj = "hommel"){
  v <- cbind(res.v, exp.v)
  test.model <- lm(res.v ~ 1, data = v) # null model first
  v.names <- colnames(v)[-1] # for test
  sel.v <- vector(mode = "character", length = ncol(exp.v))
  p.val <- vector(mode = "numeric", length = ncol(exp.v))
  f.val.v <- vector(mode = "numeric", length = ncol(exp.v))
  f.val.m <- vector(mode = "numeric", length = ncol(exp.v))
  R2Cum <- vector(mode = "numeric", length = ncol(exp.v))
  AdjR2Cum <- vector(mode = "numeric", length = ncol(exp.v))
  R2 <- vector(mode = "numeric", length = ncol(exp.v))
  scope.formula <- as.formula(paste0("~ ", paste(v.names, collapse = "+")))
  for (i in 1:ncol(exp.v)){
    step <- add1(test.model, scope = scope.formula, test = "F")
    f.val.v[i] <- max(step$`F value`, na.rm = T)
    p.val[i] <- step[which(step$`F value` == f.val.v[i]), "Pr(>F)"]
    if (p.val[i] <= test.p){
      sel.v[i] <- rownames(step[which(step$`F value` == f.val.v[i]),])
      update.formula <- as.formula(paste0("~ . + ", paste(sel.v[1:i], collapse = "+")))
      test.model <- update(test.model, update.formula)
      sum.model <- summary(test.model)
      f.val.m[i] <- sum.model$fstatistic["value"]
      R2Cum[i] <- sum.model$r.squared
      AdjR2Cum[i] <- sum.model$adj.r.squared
      if (i == 1) R2[i] <- R2Cum[i]
      else R2[i] <- R2Cum[i] - R2Cum[i-1]
    }else break
  }
  result <- data.frame(variables = sel.v[1:(i-1)], `R2` = round(R2[1:(i-1)], 5), `R2Cum` = round(R2Cum[1:(i-1)], 5), `AdjR2Cum` = round(AdjR2Cum[1:(i-1)], 5), `Fvalue` = round(f.val.m[1:(i-1)], 5), `Pvalue` = round(p.val[1:(i-1)], 5), `AdjPvalue` = round(p.adjust(p.val[1:(i-1)], method = p.adj, n = ncol(exp.v)), 5))
  return(result)
}
