//two factor ANOVA with two levels of each factor with interaction - common error standard deviation (cell mean model)
data {
  int N;                                //sample1 size
  real y[N];                            //y values
  int<lower=1,upper=2> level1[N];       //level of factor 1 (integer 1 or 2)
  int<lower=1,upper=2> level2[N];       //level of factor 2 (integer 1 or 2)
}
parameters {
  real alpha[4];                //Parameters for each of the four combinations of levels of factors 1 and 2
  real<lower=0> sigma;        //common error standard deviation
}
model {
  int j;
  alpha ~ normal(0,20);         //normal priors for each alpha
  sigma ~ cauchy(0,10);         //half-cauchy prior for error standard deviation 
  
  for (i in 1:N){                   //loop through y values
    j = 2*(level1[i]-1)+level2[i];   //compute the cell number
    y[i] ~ normal(alpha[j],sigma);  //y[j] has normal likelihood with mean alpha[j] and std deviation sigma
  }
}

