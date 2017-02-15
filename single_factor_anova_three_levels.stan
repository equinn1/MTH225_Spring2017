//single-factor ANOVA with three levels and common error standard deviation
data {
  int N;                         //sample1 size
  real y[N];                     //y values
  int<lower=1,upper=3> lvl[N];   //level for this observation (integer 1,2 or 3)
}
parameters {
  real alpha[3];                 //Parameters for each level of the single factor
  real<lower=0> sigma;           //common error standard deviation for each level
}
model {
  int j;
  alpha ~ normal(0,20);          //normal priors for each alpha level 
  sigma ~ cauchy(0,10);          //half-cauchy prior for error standard deviation 
  
  for (i in 1:N){                    //loop through y values
    j=lvl[i];                        //set j to level
    y[i] ~ normal(alpha[j],sigma);   //y[j] has normal likelihood with mean alpha[j] and std deviation sigma
  }
}
generated quantities {
  real d12;                  //declare variables to hold computed differences
  real d13;
  real d23;
  
  d12 = alpha[1]-alpha[2];    //sample difference between alpha1 and alpha2
  d13 = alpha[1]-alpha[3];    //sample difference between alpha1 and alpha3
  d23 = alpha[2]-alpha[3];    //sample difference between alpha2 and alpha3
}
