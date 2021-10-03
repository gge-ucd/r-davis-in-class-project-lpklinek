set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2
##  [1] 31.697246 12.972021 48.457102        NA 20.885307 49.487524 41.498897
##  [8] 15.682545 35.612619 42.245735  8.814791        NA 27.418158 36.504914
## [15] 43.666428 42.722117 24.582411 48.374680 10.494605 39.728776 40.971460
## [22]        NA 20.447903  6.668049 30.024323 34.314318        NA 10.825658
## [29] 46.676823 25.913006 26.933701 15.810164 26.616794  9.403891 27.589087
## [36] 34.262403  9.591257 27.733004 17.877330 38.975078 46.102046 25.041810
## [43] 46.369401 15.919465 19.813791 23.741937 19.192818 38.630297 42.819312
## [50]  4.500130
prob1 = hw2[!is.na(hw2)] # removing any NA values
prob1 <- prob1[prob1 >14 & prob1 < 38] # selecting for values between 13 and 38
prob1
times3 = prob1 * 3 # multiplying entire vector by 3
times3
plus10 = times3 + 10 # adding 10 to entire vector
plus10

# then need to select every other value
plus10[c(1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23)]


# or could do plus10[c(TRUE, FALSE)] -- from answers