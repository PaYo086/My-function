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
    The function returns a data.frame with global RMSE, R suqared, mean RMSE (global MAE) and SD. It's faster than train function in caret package, but less information (see below).
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

## part.regre.plot:
  - Description:<br/>
    Partial regression plot (Moya-Laraño and Corcobado 2008).
    
  - Arguments:<br/>
    v, y, x, line, return.lm
    
  - Details:<br/>
  	v - The data.frame include all the variables.<br/>
  	y - The order of response variable, or the name of response variable.<br/>
    x - The order of selected explanatory variable, or the name of selected explanatory variable.<br/>
    line - Logical value. Draw regression line or not.<br/>
    return.lm - Logical value. Return the information of the regression line or not. Note: It's not the full model of the multiple variables regression.

  - Examples:
```R
part.regre.plot(trees, y = 3, x = 2)
part.regre.plot(trees, y = "Volume", x = "Height")
```

## Reference:
  - Moya-Laraño, J., & Corcobado, G. 2008. Plotting partial correlation and regression in ecological studies. Web Ecology, 81, 35–46.


Coded by Po-Yu Lin<br/>
Contact me: flutter925517@gmail.com
