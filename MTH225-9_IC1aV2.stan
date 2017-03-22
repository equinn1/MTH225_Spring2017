//two factor ANOVA with two levels of each factor and no interaction - common error standard deviation
data {
  int N;                                //sample1 size
  real y[N];                            //y values
  int<lower=1,upper=2> level1[N];       //level of factor 1 (integer 1 or 2)
  int<lower=1,upper=2> level2[N];       //level of factor 2 (integer 1 or 2)
}
parameters {
  real alpha[2];                //Parameters for each level of the first factor
  real beta[2];                 //Parameters for each level of the second factor
  real<lower=0> sigma;        //common error standard deviation
}
model {
  alpha[1] ~ normal(0,20);         //normal priors for each alpha level 
  alpha[2] ~ normal(0,.02);         //normal priors for each alpha level 
  beta  ~ normal(0,20);         //normal priors for each beta level 
  sigma ~ normal(0,5);          //half-cauchy prior for error standard deviation 
  
  for (i in 1:N) {
    y[i] ~ normal(alpha[level1[i]]+beta[level2[i]],sigma);
  } 
}
generated quantities {
  real d12a;
  real d12b;
  
  d12a = alpha[1]-alpha[2];    //posterior draw difference between alpha1 and alpha2
  d12b = beta[1]-beta[2];      //posterior draw difference between alpha1 and alpha2
}
