# My-function

## forward.selection:
  - Description:<br/>
  	Perform forward selection of linear regression based on F value.
  
  - Arguments:<br/>
  	res.v, exp.v, test.p, p.adj
  
  - Details:<br/>
  	res.v - Response variable.<br/>
  	exp.v - Explanatory variables.<br/>
  	test.p - The significant P value threshold (not adj. P).<br/>
  	p.adj - The method for adjusting P values. Perform by p.adjust() function.

## LOOCV:
  - Description:<br/>
    Leave-one-out cross validation for linear regression.
    
  - Arguments:<br/>
    res.v, exp.v
    
  - Details:<br/>
  	res.v - Response variable.<br/>
  	exp.v - Explanatory variables.<br/>
    The function returns a data.frame with global RMSE, R suqared, mean RMSE (global MAE) and SD. It's faster than train function in caret package, but less information.
```R
# install.packages("caret")
library(caret)
mb <- microbenchmark::microbenchmark(
  {
    LOOCV(trees$Girth, trees$Height)
  },
  {
    train(Girth ~ Height, data = trees, method = "lm", trControl = trainControl(method = "LOOCV"))
  },
  times = 10)
mb

      min       lq      mean    median       uq      max neval cld
  24.1235  24.1474  24.75188  24.57685  25.0799  26.4324    10  a 
 368.3465 370.3210 377.62824 372.80895 375.9616 419.4949    10   b
```


Function coded by Po-Yu Lin<br/>
Contact me: flutter925517@gmail.com
