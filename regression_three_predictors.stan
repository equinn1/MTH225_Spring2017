//Regression model with three predictors
data {
  int N;               //sample size
  vector[N] y;         //y data values
  vector[N] x1;        //x1 data values
  vector[N] x2;        //x2 data values
  vector[N] x3;        //x3 data values
}
parameters {
  real beta[4];           //intercept and three 'slopes'
  real<lower=0> sigma;    //standard error
}
model {
  beta ~ normal(0,100);   //normal priors for betas
  sigma ~ cauchy(0,10);   //half-cauchy prior for sigma 
  
  y ~ normal(beta[1]+beta[2]*x1+beta[3]*x2+beta[4]*x3,sigma);   
}

