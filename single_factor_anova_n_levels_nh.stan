//single-factor ANOVA with (n_levels) levels and common standard error sigma for all levels
data {
  int N;                                //sample1 size
  int n_levels;                         //number of levels
  real y[N];                            //y values
  int<lower=1,upper=n_levels> lvl[N];   //level for this observation (integer 1 or 2)
}
parameters {
  real alpha[n_levels];                //alpha[] parameters for means, one for each level
  real<lower=0> sigma[n_levels];                 //single  common error standard deviation for all levels
}
model {
  alpha ~ normal(0,100);         //normal priors alpha[] parameters 
  sigma ~ cauchy(0,10);         //half-cauchy prior for error standard deviation 
  
  for(i in 1:N) {
     y[i] ~ normal(alpha[lvl[i]],sigma[lvl[i]]); 
  }
}

