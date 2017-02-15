//single-factor ANOVA with two levels and possibly different standard errors at each level
data {
  int N;                                //sample size
  real y[N];                            //y values
  int<lower=1,upper=2> lvl[N];          //level for this observation (integer 1 or 2)
}
parameters {
  real alpha[2];                //alpha : parameters for means at level 1 and level 2
  real<lower=0> sigma[2];       //sigma:  parameters for standard deviations at level 1 and level 2
}
model {
  int j;
  alpha ~ normal(0,20);         //normal priors for each alpha level 
  sigma ~ cauchy(0,10);         //half-cauchy priors for error standard deviations 
  
  for (i in 1:N){               //loop through y values
    j=lvl[i];
    y[i] ~ normal(alpha[j],sigma[j]);  //y[j] has normal likelihood with mean alpha[j] and std deviation sigma[j]
  }
}
generated quantities {
  real d12;
  
  d12=alpha[1]-alpha[2];    //sample difference between alpha1 and alpha2
}
