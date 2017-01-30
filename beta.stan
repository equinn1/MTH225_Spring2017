//Estimate the parameters of a beta distribution
data {
  int N;                        //sample size
  real<lower=0,upper=1> y[N];   //y consists of N real values between zero and one
}
parameters {
  real<lower=0> alpha;          //shape parameter (constrained to be nonnegative by <lower=0>)
  real<lower=0> beta;           //scale parameter (constrained to be nonnegative by <lower=0>)
}
model {
  alpha ~ normal(0,50);         //half-normal prior for shape: top half of bell curve centered at zero with sd 50
  beta  ~ normal(0,50);         //half-normal prior for scale: top half of bell curve centered at zero with sd 50
  y ~ beta(alpha,beta);         //beta likelihood given parameters alpha,beta
}
