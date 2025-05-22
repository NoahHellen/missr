#' Simulated company data (MNAR)
#'
#' A toy dataset with typical company metrics across various firms.
#'
#' @format A 500 x 5 data frame:
#' \describe{
#'   \item{sales}{Sales in the last fiscal year (USD, million)}
#'   \item{marketing_spend}{Marketing spend in last fiscal year (USD, million)}
#'   \item{product_rating}{Average rating across all products}
#'   \item{employees}{Total employee count in last fiscal year}
#'   \item{gross_profit}{Gross profit in last fiscal year (USD, million)}
#' }
"companydata"

#' Simulated health check data (MAR)
#'
#' A toy dataset with typical health check-up metrics for various individuals.
#'
#' @format A 200 x 5 data frame:
#' \describe{
#'   \item{bone_mass}{Bone mass of individual (kg)}
#'   \item{body_fat}{Body fat percentage of individual}
#'   \item{height}{Height of individual (cm)}
#'   \item{age}{Age of individual}
#'   \item{rbc}{Red blood cell count of individual (million/mm^3)}
#' }
"healthcheck"

#' Simulated pollution level data (MCAR)
#'
#' A toy dataset with typical pollution level metrics for various settlements.
#'
#' @format A 200 x 4 data frame:
#' \describe{
#'   \item{light}{Light pollution of settlement (mag/arcsec^2)}
#'   \item{visual}{Visual pollution of settlement (VPI)}
#'   \item{noise}{Noise pollution of settlement (dB)}
#'   \item{air}{Air pollution of settlement (AQI)}
#' }
"pollutionlevels"

#' Simulated animal health data (MCAR)
#'
#' A toy dataset with heart rate data for various animals.
#'
#' @format A 200 x 2 data frame:
#' \describe{
#'   \item{animal}{The animal of interest}
#'   \item{hear_rate}{The corresponding heart rate of the animal (bpm)}
#' }
"animalhealth"

#' Simulated test scores data
#'
#' A toy dataset with test scores of various students.
#'
#' @format A 200 x 2 data frame:
#' \describe{
#'   \item{id}{The ID of the student}
#'   \item{score}{The student's score in the test}
#' }
"testscores"
