#Aufgabe 3a

#dicerolling fucntion
dice_experiment <- function(number_of_times) {
  cumsum(sample(1:6, number_of_times, replace = TRUE)) / 1:number_of_times
}
# Number of rolls
n <- 10000

# Compute cumulative mean
cum_mean <- dice_experiment(n)

# Create folder if it doesn't exist
if (!dir.exists("plots")) {
  dir.create("plots")
}

# Set file path
file_path <- file.path("plots", "dice_running_average.png")

# Open PNG device
png(file_path)

# Plotting
plot(1:n, cum_mean, type = "l", col = "blue",
     xlab = "Number of Rolls", ylab = "Running Average",
     main = "Running Average of Dice Rolls")
abline(h = 3.5, col = "red", lty = 2)

# Close device
dev.off()

#3b
dice_list <- vector(mode = "list", length = 50)
for (i in 1:50){
  dice_list[[i]] <- dice_experiment(n)
}
# Convert list to matrix
dice_matrix <- do.call(cbind, dice_list)

# Plot all 50 lines
file_path <- file.path("plots", "50xdice_running_average.png")

png(file_path)
matplot(1:n, dice_matrix, type = "l", lty = 1, col = rgb(0, 0, 1, 0.3),
        xlab = "Number of Rolls", ylab = "Running Average",
        main = "Running Averages Across 50 Simulations")
abline(h = 3.5, col = "red", lty = 2)
dev.off()

#Aufgabe 3e
epsilon <- 0.01
threshold <- 0.05
num_simulations <- 50
n <- 1e6  # 1 million rolls to be safe

# Precompute simulations
dice_list <- vector(mode = "list", length = num_simulations)
for (i in 1:num_simulations){
  dice_list[[i]] <- dice_experiment(n)
}
dice_matrix <- do.call(cbind, dice_list)

# Loop through roll indices until condition is met
roll_index <- 1
proportion_outside <- 1

while (proportion_outside > threshold && roll_index <= n) {
  current_vals <- dice_matrix[roll_index, ]
  deviations <- abs(current_vals - 3.5) > epsilon
  proportion_outside <- sum(deviations) / num_simulations
  roll_index <- roll_index + 1
}

if (roll_index > n) {
  print("Threshold was not reached within 1,000,000 rolls.")
} else {
  print(paste("First roll index where proportion_outside <", threshold, ":", roll_index))
}


# Aufgabe 3f
# Aufgabe 3f
cauchy_experiment <- function(number_of_times) {
  cumsum(rcauchy(number_of_times)) / 1:number_of_times
}

cauchy_list <- vector(mode = "list", length = 50)
for (i in 1:50){
  cauchy_list[[i]] <- cauchy_experiment(10000)
}
cauchy_matrix <- do.call(cbind, cauchy_list)

file_path <- file.path("plots", "cauchy_running_average.png")

png(file_path)
matplot(1:10000, cauchy_matrix, type = "l", lty = 1, col = rgb(1, 0, 0, 0.3),
        xlab = "Number of Draws", ylab = "Running Average",
        main = "Running Averages of Standard Cauchy Distribution")
abline(h = 0, col = "blue", lty = 2)
dev.off()