# Aufgabe 4
library(ggplot2)

# Set seed for reproducibility
set.seed(123)

# c)

# Parameters
n_values <- c(100, 1000, 10000) # sample sizes
M <- 100  # number of repetitions

# For storing results
sample_means_list <- list()

# Simulate die rolls and store sample means
for (n in n_values) {
  sample_means <- replicate(M, mean(sample(1:6, size = n, replace = TRUE)))
  sample_means_list[[as.character(n)]] <- sample_means # List with keynames
}

# Plot histograms
par(mfrow = c(1, 3))  # 1 row, 3 plots by the keys

for (n in n_values) {
    means <- sample_means_list[[as.character(n)]]
  hist(sample_means_list[[as.character(n)]],
       main = paste("n =", n),
       xlab = "Sample Mean",
       probability = TRUE,  # y-axis will represent probabilities, not counts
       )
  
  # Overlay normal curve
  # Compute the mean and standard deviation of the sample means
  mean_val <- mean(means)
  sd_val <- sd(means)
  
  # Generate x values for the normal distribution curve
  x_vals <- seq(min(means), max(means), length = 100)
  y_vals <- dnorm(x_vals, mean = mean_val, sd = sd_val)
  
  # Draw the normal curve on top of the histogram
  lines(x_vals, y_vals, col = "red", lwd = 2)
}
# Diskussion: to add but more centered around the mean, less spread

# d)
# Values for a fair die
die_values <- 1:6

# Expected value (mean)
mu <- mean(die_values)

# Variance
sigma_squared <- sum((die_values - mu)^2) / length(die_values)

# Output
print(paste("Expected value (mean):", mu))
print(paste("Variance:", sigma_squared))


# e)

# Parameters
n_values <- c(100, 1000, 10000)
M_values <- c(100, 1000, 10000)
sigma = sqrt(sigma_squared)

# For storing results
zn_results <- list()

# Loop over n and M
for (n in n_values) {
  for (M in M_values) {
    
    # Simulate M means of n dice rolls
    sample_means <- replicate(M, mean(sample(1:6, size = n, replace = TRUE)))
    
    # Standardize to get Z_n
    zn <- (sample_means - mu) / (sigma / sqrt(n))
    
    # Store in list
    key <- paste0("n=", n, "_M=", M)
    zn_results[[key]] <- zn
  }
}

# Plot histograms
par(mfrow = c(3, 3))  # 3 row, 3 plots by the keys

for (key in names(zn_results)) {
  hist(zn_results[[key]],
       probability = TRUE,
       main = key,
       xlab = "Z_n")
  
  # Add standard normal curve
  x_vals <- seq(-4, 4, length = 100)
  y_vals <- dnorm(x_vals, mean = 0, sd = 1)
  lines(x_vals, y_vals, col = "red", lwd = 2)
}

# Diskussion: to add but more centered around the mean, less spread