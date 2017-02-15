//two factor ANOVA with arbitrary number of levels of each factor and no interaction - common error standard deviation
data {
  int N;                                    //sample1 size
  vector[N] y;                              //y values
  int<lower=1> alpha_levels;                //number of levels for factor 1
  int<lower=1> beta_levels;                 //number of levels for factor 2
  int<lower=1,upper=alpha_levels> lvl1[N];  //level of factor 1 for each observation
  int<lower=1,upper=beta_levels> lvl2[N];   //level of factor 2 (integer 1 or 2)
}
parameters {
  real alpha[alpha_levels];                //One alpha parameter for each level of the first factor
  real beta[beta_levels];                  //One beta parameter for each level of the second factor
  real<lower=0> sigma;                     //common error standard deviation
}
transformed parameters {
  vector[N] y_hat;                         //signal part
  for (i in 1:N) {
    y_hat[i] = alpha[lvl1[i]]+beta[lvl2[i]];
  }
}
model {
  alpha ~ normal(0,200);         //normal priors for each alpha level 
  beta  ~ normal(0,200);         //normal priors for each beta level 
  sigma ~ cauchy(0,10);         //half-cauchy prior for error standard deviation 
  y ~ normal(y_hat,sigma);      //y[j] has normal likelihood with mean alpha[j]+beta[k] and std deviation sigma 
}
