//Estimate the probability of success in a Bernoulli distribution
data {
  int N;                       //sample size
  real<lower=0> alpha;         //shape parameter 1 for beta prior
  real<lower=0> beta;          //shape parameter 2 for beta prior
  int<lower=0,upper=1> y[N];   //y consists of N binary values (zeros and ones)
}
parameters {
  real<lower=0,upper=1> theta;  //parameter theta is constrained to be between 0 and 1
}
model {
  theta ~ beta(alpha,beta);    //beta(1,1) is a uniform prior: all values between 0 and 1 equally likely 
  y ~ bernoulli(theta);        //Bernoulli likelihood given parameter theta
}
