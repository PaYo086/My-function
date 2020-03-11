# partial regression plot
part.regre.plot <- function(v, y = 1, x = 2, line = TRUE, return.lm = FALSE){
  if (is.numeric(x) & is.numeric(y)){
    y.formula <- as.formula(paste0(colnames(v)[y], " ~ ."))
    x.formula <- as.formula(paste0(colnames(v)[x], " ~ ."))
    plot(resid(lm(y.formula, data = v[,-x])) ~ resid(lm(x.formula, data = v[,-y])), ylab = paste0("Residual of ", colnames(v)[y]), xlab = paste0("Residual of ", colnames(v)[x]), asp = 1)
    if (line){
      lm.v <- lm(resid(lm(y.formula, data = v[,-x])) ~ resid(lm(x.formula, data = v[,-y])))
      abline(lm.v, col = "red")
    }
  } else{
    order <- c(which(colnames(v) == y), which(colnames(v) == x))
    colnames(v)[order] <- c("res.v", "exp.v")
    plot(resid(lm(res.v ~ ., data = v[, -order[2]])) ~ resid(lm(exp.v ~ ., data = v[, -order[1]])), ylab = paste0("Residual of ", y), xlab = paste0("Residual of ", x), asp = 1)
    if (line){
      lm.v <- lm(resid(lm(res.v ~ ., data = v[, -order[2]])) ~ resid(lm(exp.v ~ ., data = v[, -order[1]])))
      abline(lm.v, col = "red")
    }
  }
  if (return.lm){
    invisible(lm.v)
  }
}
