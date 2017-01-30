//Estimate the probability of success in a Bernoulli distribution
data {
  int<lower=0> y;   //y consists of N binary values (zeros and ones)
}
parameters {
  real<lower=0> theta;  //parameter theta is constrained to be between 0 and 1
}
model {
  theta ~ normal(0,100);          //beta(1,1) is a uniform prior: all values between 0 and 1 equally likely 
  y ~ exponential(theta);       //Bernoulli likelihood given parameter theta
}
