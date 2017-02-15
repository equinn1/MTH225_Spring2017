//single-factor ANOVA with two levels and common standard error for all levels
data {
  int N;                                //sample1 size
  real y[N];                            //y values
  int<lower=1,upper=2> lvl[N];          //level for this observation (integer 1 or 2)
}
parameters {
  real alpha[2];                //alpha[] parameters for means, one for each level
  real<lower=0> sigma;          //single  common error standard deviation for all levels
}
model {
  int j;
  alpha ~ normal(0,20);         //normal priors alpha[] parameters 
  sigma ~ cauchy(0,10);         //half-cauchy prior for error standard deviation 
  
  for (i in 1:N){               //loop through y values
    j=lvl[i];                        //set subscript for level 1 or level 2
    y[i] ~ normal(alpha[j],sigma);    //y[j] has normal likelihood with mean alpha[j] and std deviation sigma
  }
}
generated quantities {
  real d12;                  //declare variable for difference between alpha[1] and alpha[2] 
  
  d12=alpha[1]-alpha[2];    //compute sample difference between alpha[1] and alpha[2]
}
