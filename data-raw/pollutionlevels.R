set.seed(11)

pollutionlevels <- data.frame(
  light = runif(n = 200, min = 16, max = 22),
  visual = runif(n = 200, min = 0, max = 1),
  noise = runif(n = 200, min = 30, max = 140),
  air = sample(0:300, 200, replace = TRUE)
)

miss_prob <- 0.5

pollutionlevels$noise[sample(1:200, size = floor(200 * miss_prob))] <- NA

usethis::use_data(pollutionlevels, overwrite = TRUE)
