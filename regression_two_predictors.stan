//Regression model with two predictors
data {
  int N;               //sample size
  vector[N] y;         //y data values
  vector[N] x1;        //x1 data values
  vector[N] x2;        //x2 data values
}
parameters {
  real beta[3];           //intercept and two 'slopes'
  real<lower=0> sigma;    //standard error
}
model {
  beta ~ normal(0,100);   //normal priors for intercept and slope
  sigma ~ cauchy(0,10);   //half-cauchy prior for sigma 

  y ~ normal(beta[1]+beta[2]*x1+beta[3]*x2,sigma);   
}

