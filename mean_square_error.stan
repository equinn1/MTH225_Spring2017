//Estimate the bias and mean square error in a set of measurements
data {
  int N;                          //sample size
  vector[N] y;                    //true value
  vector[N] y_meas;               //sensor measurement
}
transformed data {
  vector[N] measurement_error;                 //measurement error
  for(i in 1:N) {
    measurement_error[i] = y_meas[i] - y[i];  
  }
}
parameters {
  real bias;                   //mean of measurement errors - should be zero if unbiased 
  real<lower=0> sigma_e;       //standard deviation of measurement errors
}
model {
  bias ~ normal(0,100);      
  sigma_e ~ cauchy(0,10);        //half-cauchy prior for standard deviations 
  
  measurement_error ~ normal(bias,sigma_e);
}
generated quantities {
  real Variance;             
  real MSE;

  Variance = sigma_e*sigma_e;       //variance is standard deviation squared
  MSE = bias*bias+sigma_e*sigma_e;  //MSE is variance +bias squared 
}
