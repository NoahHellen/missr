test_that("mar() accepts as input a data.frame only", {
  expect_error(mar(c(1, 2)), "Expected a data.frame object.")
  expect_error(mar(matrix(c(1, 2))), "Expected a data.frame object.")
})

test_that("mar() accepts data with missing values only", {
  expect_error(
    mar(testscores),
    "There is no missing data in this dataset."
  )
})

test_that("mar() warns users of non-numeric encoding", {
  expect_warning(
    mar(animalhealth),
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
