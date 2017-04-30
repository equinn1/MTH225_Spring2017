//simple regression with measurement error
data {
  int N;                        //sample1 size
  vector[N] y;                  //y values
  vector[N] x_meas;             //x value with measurement error
  real<lower=0> tau;            //standard deviation of x measurements
}
parameters {
  real alpha;                   //intercept
  real beta;                    //slope
  real<lower=0> sigma;          //residual error standard deviation
  vector[N] x;                    //unknown true x value
  real mu_x;                    //pior mean for measurement error model
  real<lower=0> sigma_x;        //prior sd for measurement error model
}
model {
  x ~ normal(mu_x,sigma_x);     //prior for true value of x
  x_meas ~ normal(x,tau);       //measurement error model
  alpha ~ normal(0,10);         //normal prior for intercept
  beta ~ normal(0,10);          //normal prior for slope
  sigma ~ cauchy(0,5);          //half-cauchy prior for error standard deviation 

  y ~ normal(alpha + beta * x,sigma); 
}

