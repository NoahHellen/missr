test_vector <- c(1, 2)
test_no_miss_matrix <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
test_num_matrix <- matrix(c(1, NA, NA, 1, 4, NA), nrow = 3, ncol = 2)
test_mix_matrix <- matrix(c(1, NA, "Viola", "Guitar"), nrow = 2, ncol = 2)
test_num_df <- as.data.frame(test_num_matrix)
test_no_miss_df <- as.data.frame(test_no_miss_matrix)
test_mix_df <- as.data.frame(test_mix_matrix)

test_that("mar() accepts as input a data.frame only", {
  expect_error(mar(test_vector), "Expected a data.frame object.")
  expect_error(mar(test_num_matrix), "Expected a data.frame object.")
})

test_that("mar() accepts data with missing values only", {
  expect_error(
    mar(test_no_miss_df),
    "There is no missing data in this dataset."
  )
})

test_that("mar() warns users of non-numeric encoding", {
  expect_warning(
    mar(test_mix_df),
    "Non-numeric columns encoded - verify interpretable."
  )
})

test_that("mar() calculates correct statistics", {
  result <- mar(healthcheck)
  expect_equal(result$missing, "rbc")
  expect_equal(result$explanatory, "age")
  expect_equal(
    result$p_values$rbc,
    c(
      0.462530896,
      0.570560304,
      0.325466057,
      0.001876293,
      0.489528756
    )
  )
  expect_equal(
    result$variables$rbc,
    c(
      "bone_mass",
      "body_fat",
      "height",
      "age",
      "rbc"
    )
  )
})
