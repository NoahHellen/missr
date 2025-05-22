set.seed(19)

companydata <- data.frame(
  sales = rexp(n = 500, rate = 0.1),
  marketing_spend = rexp(n = 500, rate = 0.2),
  product_rating = runif(n = 500, min = 0, max = 10),
  employees = sample(5:500, 500, replace = TRUE),
  gross_profit = runif(500, min = 3.5, max = 6)
)

mar_prob <- 0.3 * exp(-0.05 * companydata$gross_profit)
mcar_prob <- 0.1

set_na <- runif(nrow(companydata)) < mar_prob
companydata$employees[set_na] <- NA
companydata$product_rating[sample(1:500, size = floor(500 * mcar_prob))] <- NA

usethis::use_data(companydata, overwrite = TRUE)
