//Estimate the parameters of a gamma distribution
data {
  int N;                        //sample size is N
  real<lower=0> y[N];           //y consists of N real values constrained nonnegative by <lower=0>
}
parameters {
  real<lower=0> alpha;          //shape parameter (constrained nonnegative by <lower=0>)
  real<lower=0> beta;           //scale parameter (constrained nonnegative by <lower=0>)
}
model {
  alpha ~ normal(0,50);         //half-normal prior for alpha: top half of bell curve centered at zero with sd 50
  beta  ~ normal(0,50);         //half-normal prior for beta: top half of bell curve centered at zero with sd 50 
  y ~ gamma(alpha,beta);        //gamma likelihood given parameters alpha,beta
}
