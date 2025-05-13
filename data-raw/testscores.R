set.seed(12)

id <- paste0("student_", 1:200)

score <- round(runif(n = 200, min = 40, max = 100), 1)

testscores <- data.frame(
  id = id,
  score = score
)

usethis::use_data(testscores, overwrite = TRUE)
