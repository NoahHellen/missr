set.seed(11)

animals <- c("human", "cow", "rabbit", "cat")
animal_list <- sample(animals, size = 200, replace = TRUE)

heart_rate_means <- c(human = 75, cow = 65, rabbit = 220, cat = 160)
heart_rate_sds <- c(human = 10, cow = 8, rabbit = 30, cat = 25)

heart_rates <- sapply(animal_list, function(animal) {
  rnorm(1, mean = heart_rate_means[animal], sd = heart_rate_sds[animal])
})

heart_rates <- pmax(heart_rates, 20)

animalhealth <- data.frame(
  animal = animal_list,
  heart_rate = round(heart_rates, 1)
)

miss_prob <- 0.5

animalhealth$heart_rate[sample(1:200, size = floor(200 * miss_prob))] <- NA

usethis::use_data(animalhealth, overwrite = TRUE)
