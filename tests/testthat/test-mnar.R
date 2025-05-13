test_that("mnar() accepts as input a `data.frame` only", {
  expect_error(mcar(c(1, 2)), "Expected a data.frame object.")
  expect_error(mcar(matrix(c(1, 2))), "Expected a data.frame object.")
})

test_that("mnar() accepts data with missing values only", {
  expect_error(
    mcar(testscores),
    "There is no missing data in this dataset."
  )
})

test_that("mnar() warns users of non-numeric encoding", {
  expect_warning(mcar(animalhealth), "Non-numeric columns encoded - verify
    interpretable.")
})
