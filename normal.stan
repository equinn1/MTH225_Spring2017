//Estimate the perameters of a normal distribution
data {
  int N;               //sample size is N
  real y[N];           //y consists of N real data values
}
parameters {
  real mu;                //location parameter for normal
  real<lower=0> sigma;    //dispersion parameter (standard deviation) constrained nonegative by <lower=0>
}
model {
  mu ~ normal(0,100);     //normal prior for mu: centered at zero with sd=100 ("uninformative") 
  sigma ~ cauchy(0,10);   //half-cauchy prior for sigma: centered at zero with scale=10 ("uninformative") 
  y ~ normal(mu,sigma);   //normal likelihood given parameters (mu,sigma)
}
