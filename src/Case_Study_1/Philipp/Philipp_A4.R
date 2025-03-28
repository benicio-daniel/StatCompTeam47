# Aufgabe 4
library(ggplot2)

# Set seed for reproducibility
set.seed(123)

# c)

# Parameters
n_values <- c(100, 1000, 10000)
M <- 100  # number of repetitions
sample_means_list <- list()

# Simulate die rolls and store sample means
for (n in n_values) {
  sample_means <- replicate(M, mean(sample(1:6, size = n, replace = TRUE)))
  sample_means_list[[as.character(n)]] <- sample_means
}

# Plot histograms
par(mfrow = c(1, 3))  # 1 row, 3 plots

for (n in n_values) {
  hist(sample_means_list[[as.character(n)]],
       breaks = 15,
       main = paste("n =", n),
       xlab = "Sample Mean",
       col = "lightblue",
       probability = TRUE)
  
  # Overlay normal curve
  x_vals <- seq(1, 6, length = 100)
  mean_val <- 3.5  # Expected value of die
  sd_val <- sqrt(35/12) / sqrt(n)  # Variance of die = (6^2 - 1)/12
  lines(x_vals, dnorm(x_vals, mean = mean_val, sd = sd_val), col = "red", lwd = 2)
}


# d)
