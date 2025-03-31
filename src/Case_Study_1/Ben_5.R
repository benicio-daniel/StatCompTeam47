#Aufgabe 5a
set.seed(1)
x <- rnorm(100)
z <- rnorm(100)
#thsi block creates two normal distributions
fit <- lm(x ~ z)
r <- fit$residuals
x <- sin(r) + .01
if (sum(x >= .002) < 2) {
  stop("step 2 requires 2 observation(s) with value >= .002")
}
# we are fitting linear models according and Updates x with a sinusoidal transformation of the residuals, scaled and shifted:

set.seed(1)
x <- rnorm(1000)
y <- 2 + x + rnorm(1000)
df <- data.frame(x, y)
#we create a data frame with nomrla distributed data frame

cat("Step", 1, "\n")
fit1 <- lm(y ~ x, data = df[-(1:250),])
p1 <- predict(fit1, newdata = df[(1:250),])
r <- sqrt(mean((p1 - df[(1:250),"y"])^2))
# we then again fit a model on a chunk of data, predict on the excluded chunk,and comute the sqare root of error

#Aufgabe 5b
#Comment, what the intent of the code is
# also write it in functions. 
#Then you would have to name variables to make it more understandable

#Aufgabe 5c
model_step_analysis <- function(data, x_vec, z_vec, scalar, constant, interval_idx, step_n) {
  fit <- lm(x_vec ~ z_vec)
  residuals <- fit$residuals
  x_new <- scalar * sin(residuals) + constant
  if (sum(x_new >= (constant + 0.01)) < (scalar + 1)) {
    stop(paste("step", scalar + 1, "requires", scalar + 1,
               "observation(s) with value >=", (constant + 0.01)))
  }
  cat("Step", step_n, "\n")
  model <- lm(y ~ x, data = data[-interval_idx, ])
  preds <- predict(model, newdata = data[interval_idx, ])
  sqrt(mean((preds - data[interval_idx, "y"])^2))
}