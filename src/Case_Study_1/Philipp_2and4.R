# Aufgabe 2
#a)
rho_n <- function(n) {
    if (n < 2) {
        print("n must be > 2")
        return(NA)
    } else if (!is.numeric(n)) {
        print("n must be numeric")
        return(NA)
    }

  numerator <- gamma((n - 1) / 2)
  denominator <- gamma(1 / 2) * gamma((n - 2) / 2) # this is why n must be > 2
  result <- numerator / denominator

  print(result)
  return(result)
}

#b)
rho_n(2000)
print(gamma(2000))
# as seen in the line the gamma function returns inf for n = 2000 so inf/inf = NaN

#c)
rho_n_log <- function(n) {
    if (n < 2) {
        print("n must be > 2")
        return(NA)
    } else if (!is.numeric(n)) {
        print("n must be numeric")
        return(NA)
    }

  numerator <- lgamma((n - 1) / 2) 
  # this the same as log(gamma(n)) but it is using the stirling approximation for n! and using the log gamma function in this approximation, not after the calculation:
  # so this: \log(\Gamma(n)) \approx \left(n - \frac{1}{2}\right)\log(n) - n + \frac{1}{2}\log(2\pi) isn't going in it's steps so fast to inf as.:
  # \log(\Gamma(n) \approx \log(\sqrt{2\pi} \, n^{n - \frac{1}{2}} e^{-n}) as n -> inf (because lower values are computed)
  denominator <- lgamma(1 / 2) + lgamma((n - 2) / 2)
  result <- exp(numerator - denominator)
  
  print(result)
  return(result)
}
rho_n_log(2000)

#d)
library(ggplot2)

# Stable implementation of ρ_n
rho_n <- function(n) {
  log_rho <- lgamma((n - 1) / 2) - (lgamma(0.5) + lgamma((n - 2) / 2))
  return(exp(log_rho))
}

# Compute rho_n / sqrt(n) for values of n
n_vals <- 3:2000
rho_vals <- sapply(n_vals, function(n) rho_n(n) / sqrt(n))

# Create data frame for plotting
df <- data.frame(n = n_vals, rho_over_sqrt_n = rho_vals)

# Plot with ggplot2
ggplot(df, aes(x = n, y = rho_over_sqrt_n)) +
  geom_line(color = "steelblue") +
  labs(title = expression(frac(rho[n], sqrt(n))~"vs. n"),
       x = "n",
       y = expression(frac(rho[n], sqrt(n)))) +
  theme_minimal()


# Aufgabe 4