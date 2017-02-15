//single-factor ACNOVA with two levels, one covariate, common slope and common standard error for all levels
data {
  int N;                                //sample1 size
  int n_levels;                         //number of levels
  real y[N];                            //y values
  real x[N];                            //x values (covariate)
  int<lower=1,upper=n_levels> lvl[N];   //level for this observation
}
parameters {
  real alpha[n_levels];                 //Parameters for the two intercepts
  real beta;                            //common slope parameter
  real<lower=0> sigma;                  //common error standard deviation
}
transformed parameters{
  vector[N] y_hat;
  for (i in 1:N){
    y_hat[i] = alpha[lvl[i]]+beta*x[i];
  }
}
model {
  alpha ~ normal(0,20);                //normal priors for two intercepts
  beta  ~ normal(0,20);                //normal prior for common slope
  sigma ~ cauchy(0,10);                //half-cauchy prior for error standard deviation 
  
  y ~ normal(y_hat,sigma);             //y[j] has normal likelihood with mean alpha[j]+beta*x[i] and std deviation sigma
}
