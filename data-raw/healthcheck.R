set.seed(6)

healthcheck <- data.frame(
  bone_mass = runif(n = 200, min = 1.5, max = 3.5),
  body_fat = runif(n = 200, min = 7, max = 40),
  height = runif(n = 200, min = 100, max = 200),
  age = sample(5:100, 200, replace = TRUE),
  rbc = runif(200, min = 3.5, max = 6)
)

# Children more afraid of needles, hence missing blood test data
miss_prob <- 0.3 * exp(-0.05 * healthcheck$age)

set_na <- runif(nrow(healthcheck)) < miss_prob
healthcheck$rbc[set_na] <- NA

usethis::use_data(healthcheck, overwrite = TRUE)
