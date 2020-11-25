n <- 100;
t <- rep(c(0,1), c(n/2,n/2));
x <- c(runif(n/2), runif(n/2));

beta0 <- 0;
beta1 <- 2;
tau <- 1;
sigma <- .2;

y <- beta0 + beta1 * x + t * tau + rnorm(n, sd = sigma)

plot(x,y, type = "n", frame = FALSE)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2+1) : n]), lwd = 3)
fit <- lm(y ~ x + t)
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2], lwd = 3)
points(x[1:(n/2)], y[1:(n/2)], pch= 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2+1): n], y[(n/2+1):n], pch= 21, col = "black", bg = "salmon", cex = 2)