//Estimate the parameter of an exponential distribution
data {
  int<lower=1> N;   // sample size
  vector[N] y;      // ovserved data values
  real prior_max;   // upper limit for uniform prior
}
parameters {
  real<lower=0> theta;  //parameter theta is constrained to be positive
}
model {
  theta ~ uniform(0,prior_max); //uniform prior for theta 
  y ~ exponential(theta);       //exponential likelihood given parameter theta
}

