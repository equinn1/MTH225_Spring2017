//two factor ANOVA with two levels of each factor with interaction - common error standard deviation, cell mean model
data {
  int N;                                //sample1 size
  real y[N];                            //y values
  int<lower=1,upper=2> level1[N];       //level of factor 1 (integer 1 or 2)
  int<lower=1,upper=2> level2[N];       //level of factor 2 (integer 1 or 2)
}
parameters {
  real mu[4];                 // number of combinations of levels
  real<lower=0> sigma;        //common error standard deviation
}
model {
  int j;                        //index into parameter array
  mu ~ normal(0,20);            //normal priors for each cell mean 
  sigma ~ cauchy(0,5);          //half-cauchy prior for error standard deviation 
  
  for (i in 1:N) {
    
    if (level1[i] == 1) {
      if (level2[i] == 1) j=1;  //factor 1 is level 1, factor 2 is level 1 (cell 1,1) mu[1]  
      if (level2[i] == 2) j=2;  //factor 1 is level 1, factor 2 is level 2 (cell 1,2) mu[2]
      }
    if (level1[i] == 2) {
      if (level2[i] == 1) j=3;  //factor 1 is level 2, factor 2 is level 1 (cell 2,1) mu[3]
      if (level2[i] == 2) j=4;  //factor 1 is level 2, factor 2 is level 2 (cell 2,2) mu[4]
      }
      
    y[i] ~ normal(mu[j],sigma);
  } 
}
generated quantities {
  real d11_21;
  real d12_22;
  real d11_12;
  real d21_22;
  
  d11_21 = mu[1]-mu[3];   //difference between levels of factor 1 when level 2 is 1 
  d12_22 = mu[2]-mu[4];   //difference between levels of factor 1 when level 2 is 2 
  d11_12 = mu[1]-mu[2];   //difference between levels of factor 2 when level 1 is 1 
  d21_22 = mu[3]-mu[4];   //difference between levels of factor 2 when level 1 is 2 
}
