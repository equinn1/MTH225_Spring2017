//Compare parameter of Bernoulli distribution to hypothetical value
data {
  int N;                               //sample size
  int n_sites;                         //number of sites
  int y[N];                            //data values (counts)
  vector[N] x;                         //covariate
  int <lower=1,upper=n_sites> lvl[N];  //factor levels
}
parameters {
  real alpha[n_sites];                 //intercept of regression line
  real beta;                           //slope coefficient
}
transformed parameters{
  vector[N] theta;
  for (i in 1:N) {
    theta[i] = alpha[lvl[i]]+beta*x[i];
  }
}
model {
  alpha ~ normal(0,20);               //priors for intercepts by site
  beta  ~ normal(0,20);               //prior for common slope
  
  y ~ poisson_log(theta);    //likelihood: normal distribution with mean mu and sd sigma
}
generated quantities {
  int y_pred[N];
  for (i in 1:N) {
    y_pred[i] = poisson_log_rng(theta[i]);
  }
}

