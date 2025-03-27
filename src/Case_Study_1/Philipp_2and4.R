# Aufgabe 2
#a)
gamma <- function(n) {
    factorial(n-1)
}

gamma_function <- function(n) {
  numerator <- gamma((n - 1) / 2)
  denominator <- gamma(1 / 2) * gamma((n - 2) / 2)
  result <- numerator / denominator
  return(result)
}


# Aufgabe 4