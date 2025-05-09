set.seed(12)

companydata <- data.frame(
  sales = rexp(n = 200, rate = 0.1),
  marketing_spend = rexp(n = 200, rate = 0.2),
  product_rating = runif(n = 200, min = 0, max = 10),
  employees = sample(5:100, 200, replace = TRUE),
  gross_profit = runif(200, min = 3.5, max = 6)
)

mar_prob <- 0.4 * exp(-0.005 * companydata$gross_profit)
mcar_prob <- 0.05

set_na <- runif(nrow(companydata)) < mar_prob
companydata$employees[set_na] <- NA
companydata$product_rating[sample(1:200, size = floor(200 * mcar_prob))] <- NA

usethis::use_data(companydata, overwrite = TRUE)
